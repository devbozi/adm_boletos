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
        format: InputImageFormatValue.fromRawValue(image.format.raw) ?? InputImageFormat.nv21,
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
          final linhaDigitavel = barcode.rawValue!.replaceAll(RegExp(r'\s+'), '');

          final valor = _extrairValor(linhaDigitavel);
          final vencimento = _extrairDataVencimento(linhaDigitavel);

          await _cameraController?.stopImageStream();

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

  void _solicitarDataManual() async {
    final DateTime? selecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selecionada != null) {
      setState(() {
        _vencimento = DateFormat('dd/MM/yyyy').format(selecionada);
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Leitor de Boletos')),
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
            bottom: _mostrarDados ? 30 : -300,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _mostrarDados ? 1.0 : 0.0,
              child: Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Código de Barras:', style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      SelectableText(
                        _codigoCompleto ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          if (_codigoCompleto != null) {
                            Clipboard.setData(
                              ClipboardData(text: _codigoCompleto!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Código copiado!')),
                            );
                          }
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar código'),
                      ),
                      const Divider(),
                      if (_valor != null)
                        Text('Valor: $_valor', style: const TextStyle(fontSize: 16)),
                      if (_vencimento != null)
                        Text('Vencimento: $_vencimento', style: const TextStyle(fontSize: 16)),
                      if (_vencimento == null)
                        TextButton.icon(
                          onPressed: _solicitarDataManual,
                          icon: const Icon(Icons.edit_calendar),
                          label: const Text('Inserir data manualmente'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
