import 'package:adm_boletos/models/boleto.dart';
import 'package:adm_boletos/services/boleto_storage.dart';
import 'package:adm_boletos/utils/boleto_utils.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  CameraController? _cameraController;
  late BarcodeScanner _barcodeScanner;
  bool _isDetecting = false;

  String? _codigoCompleto;
  String? _valor;
  String? _vencimento;
  bool _mostrarDados = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.all]);
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) return;

    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );

    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();
    await _cameraController!.startImageStream(_processCameraImage);

    setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    final WriteBuffer allBytes = WriteBuffer();
    for (final plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format:
            InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );

    try {
      final barcodes = await _barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        final barcode = barcodes.first;

        if (barcode.rawValue != null &&
            barcode.rawValue!.length >= 44 &&
            barcode.rawValue!.length <= 48) {
          final linhaDigitavel = barcode.rawValue!.replaceAll(
            RegExp(r'\s+'),
            '',
          );
          final valor = _extrairValor(linhaDigitavel);
          String? vencimento = _extrairDataVencimento(linhaDigitavel);

          await _cameraController?.stopImageStream();

          if (vencimento == null) {
            vencimento = await _solicitarDataManual();
            if (vencimento == null) {
              _isDetecting = false;
              return;
            }
          }

          final novoBoleto = Boleto(
            codigo: linhaDigitavel,
            valor: valor ?? '',
            vencimento: vencimento,
            status: calcularStatus(vencimento),
          );

          try {
            await salvarBoleto(novoBoleto);
          } catch (e) {
            debugPrint('Erro ao salvar boleto: $e');
          }

          setState(() {
            _codigoCompleto = linhaDigitavel;
            _valor = valor;
            _vencimento = vencimento;
            _mostrarDados = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Erro ao escanear: $e');
    }

    _isDetecting = false;
  }

  Future<String?> _solicitarDataManual() async {
    if (!mounted) return null; // Protege o uso do context
    final DateTime? selecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return null; // Protege o uso do context após await
    if (selecionada != null) {
      return DateFormat('dd/MM/yyyy').format(selecionada);
    }

    return null;
  }

  String? _extrairValor(String linha) {
    try {
      if (linha.length == 47) {
        final valorRaw = linha.substring(37, 47);
        final centavos = int.parse(valorRaw) / 100;
        return NumberFormat.simpleCurrency(locale: 'pt_BR').format(centavos);
      } else if (linha.length == 44) {
        final valorRaw = linha.substring(9, 19);
        final centavos = int.parse(valorRaw) / 100;
        return NumberFormat.simpleCurrency(locale: 'pt_BR').format(centavos);
      } else if (linha.length == 48) {
        final valorRaw = linha.substring(4, 15);
        final centavos = int.parse(valorRaw) / 100;
        return NumberFormat.simpleCurrency(locale: 'pt_BR').format(centavos);
      }
    } catch (_) {}
    return null;
  }

  String? _extrairDataVencimento(String linha) {
    try {
      if (linha.length == 47) {
        final fator = int.parse(linha.substring(33, 37));
        final baseDate = DateTime(1997, 10, 7);
        final vencimento = baseDate.add(Duration(days: fator));
        return DateFormat('dd/MM/yyyy').format(vencimento);
      } else if (linha.length == 44 && linha.startsWith('8')) {
        return null;
      }
    } catch (_) {}
    return null;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Escanear Boleto')),
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          if (_mostrarDados)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white60,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Código: $_codigoCompleto', textAlign: TextAlign.center),
                      Text('Valor: $_valor'),
                      Text('Vencimento: $_vencimento'),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Adicionar Boleto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          if (_codigoCompleto != null &&
                              _valor != null &&
                              _vencimento != null) {
                            final novoBoleto = Boleto(
                              codigo: _codigoCompleto!,
                              valor: _valor!,
                              vencimento: _vencimento!,
                              status: calcularStatus(_vencimento!),
                            );

                            // Captura os helpers antes do await
                            final messenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);

                            try {
                              await salvarBoleto(novoBoleto);
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Boleto salvo com sucesso!'),
                                ),
                              );
                              navigator.pop();
                            } catch (e) {
                              debugPrint('Erro ao salvar boleto: $e');
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Erro ao salvar boleto'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
