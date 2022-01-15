import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final FutureOr<Uint8List> pdfFile;
  const PdfPreviewScreen({
    Key? key,
    required this.pdfFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice Preview",
        ),
      ),
      // body: PDFViewer(
      //   document: pdfFile,
      // ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting: false,
        canDebug: false,
        build: (format) => pdfFile,
      ),
    );
  }
}
