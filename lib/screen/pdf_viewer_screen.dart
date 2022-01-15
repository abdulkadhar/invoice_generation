import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  final FutureOr<Uint8List> pdfPreviewData;
  const PdfPreviewScreen({
    Key? key,
    required this.pdfPreviewData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice Preview",
        ),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting: false,
        build: (format) => pdfPreviewData,
      ),
    );
  }
}
