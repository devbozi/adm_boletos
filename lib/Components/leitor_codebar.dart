import 'package:adm_boletos/components/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Container leitorQr() {
  return Container(
    width: 60,
    height: 60,
    clipBehavior: Clip.hardEdge,
    decoration: const BoxDecoration(shape: BoxShape.circle),
    child: ColorFundoIcon(
      child: IconButton(
        icon: const Icon(
          Icons.document_scanner_outlined,
          color: Colors.white,
          size: 32,
        ),
        onPressed: scanBarcode,
      ),
    ),
  );
}

Future<void> scanBarcode() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
       'Cancelar',
        true,
         ScanMode.BARCODE);
         if (kDebugMode) {
           print('Codigo escaneado: $barcodeScanRes');
         }
  } catch (e) {
    barcodeScanRes = 'Erro ao escanear';
  }
}
