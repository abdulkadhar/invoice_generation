import 'dart:io';
import 'package:flutter/material.dart';
import 'package:invoice_generate/screen/pdf_viewer_screen.dart';
import 'package:printing/printing.dart';

class GeneratedPdfPage extends StatefulWidget {
  final List<File> files;
  const GeneratedPdfPage({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  _GeneratedPdfPageState createState() => _GeneratedPdfPageState();
}

class _GeneratedPdfPageState extends State<GeneratedPdfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Generated Invoices",
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) => InkWell(
          onLongPress: () async {
            Printing.sharePdf(
              bytes: await widget.files[index].readAsBytes(),
              filename: widget.files[index].path.split("/").last,
            );
          },
          onTap: () async {
            // PDFDocument loadFile =
            //     await PDFDocument.fromFile(widget.files[index]);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfPreviewScreen(
                  pdfFile: widget.files[index].readAsBytes(),
                ),
              ),
            );
          },
          child: Card(
            child: Center(
              child: Text(
                widget.files[index].path.split("/").last,
              ),
            ),
          ),
        ),
        itemCount: widget.files.length,
      ),
    );
  }
}
