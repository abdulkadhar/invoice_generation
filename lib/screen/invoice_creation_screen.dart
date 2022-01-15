import 'dart:math';

import 'package:flutter/material.dart';
import 'package:invoice_generate/model/address_model.dart';
import 'package:invoice_generate/model/amount_model.dart';
import 'package:invoice_generate/model/product_detail_model.dart';
import 'package:invoice_generate/screen/pdf_list_screen.dart';
import 'package:invoice_generate/screen/pdf_viewer_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceCreation extends StatefulWidget {
  const InvoiceCreation({Key? key}) : super(key: key);

  @override
  _InvoiceCreationState createState() => _InvoiceCreationState();
}

class _InvoiceCreationState extends State<InvoiceCreation> {
  final pdf = pw.Document();

  pw.SizedBox companySection() {
    return pw.SizedBox(
      width: 300,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Company Name",
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 30,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("173 krishna nagar ,"),
                  pw.Text("1st cross "),
                  pw.Text("Ammapet"),
                  pw.Text("Salem-3"),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("+91 9047020303"),
                  pw.Text("s.adulkadhar11@gmail.com"),
                  pw.Text("s.abdulkadhar1@gmail.com"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Row labelSection(
      {required String label, required String value, bool isAmount = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label + ': '),
        pw.Container(
          color: isAmount ? PdfColors.white : PdfColor.fromHex("faebd7"),
          child: pw.Text(
            value,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  pw.SizedBox invoiceSection() {
    return pw.SizedBox(
      width: 200,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Invoice Details",
            style: pw.TextStyle(
              color: PdfColors.black,
              fontSize: 20,
            ),
          ),
          pw.SizedBox(height: 10),
          labelSection(
            label: "Date",
            value: "13/01/2021",
          ),
          pw.SizedBox(height: 5),
          labelSection(
            label: "Invoice Number",
            value: "23234545670",
          ),
          pw.SizedBox(height: 5),
          labelSection(
            label: "Customer ID",
            value: "345678",
          ),
          pw.SizedBox(height: 5),
          labelSection(
            label: "Purchase Date",
            value: "10/01/2021",
          ),
          pw.SizedBox(height: 5),
          labelSection(
            label: "Payment due on",
            value: "17/01/2021",
          ),
        ],
      ),
    );
  }

  pw.SizedBox addressSection({
    required String title,
    required AddressModel model,
    double width = 200,
  }) {
    return pw.SizedBox(
      width: width,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: double.infinity,
            color: PdfColor.fromHex("ffdab9"),
            padding: pw.EdgeInsets.all(
              10,
            ),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(model.addressLine1),
          pw.Text(model.addressLine2),
          pw.Text(model.addressLine3),
          pw.Text(model.district),
          pw.Text(model.pincode),
          pw.Text(model.mobileNNumber),
        ],
      ),
    );
  }

  pw.Container tableRow({
    required ProductDetail detail,
    bool isHeading = false,
  }) {
    return pw.Container(
        padding: pw.EdgeInsets.symmetric(vertical: 10),
        color:
            isHeading ? PdfColor.fromHex("ffdab9") : PdfColor.fromHex("faebd7"),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [
            pw.SizedBox(
              width: 200,
              child: pw.Text(isHeading ? "Description" : detail.description),
            ),
            pw.Flexible(
              flex: 1,
              child: pw.Text(
                  isHeading ? "Unit Price" : detail.unitPrice.toString()),
            ),
            pw.Flexible(
              flex: 1,
              child: pw.Text(isHeading ? "Qty" : detail.quantity.toString()),
            ),
            pw.Flexible(
              flex: 1,
              child: pw.Text(isHeading
                  ? "Amount"
                  : (detail.quantity * detail.unitPrice).toString()),
            ),
          ],
        ));
  }

  pw.SizedBox amountDetails({required AmountModel model}) {
    return pw.SizedBox(
      width: 150,
      child: pw.Column(
        children: [
          labelSection(
            label: 'Subtotal ',
            value: model.subTotal.toStringAsFixed(0),
            isAmount: true,
          ),
          pw.SizedBox(height: 10),
          labelSection(
            label: 'Discount ',
            value: model.discount.toStringAsFixed(0),
            isAmount: true,
          ),
          pw.SizedBox(height: 10),
          labelSection(
            label: 'Tax Rate ',
            value: model.taxPercent.toStringAsFixed(0),
            isAmount: true,
          ),
          pw.SizedBox(height: 10),
          labelSection(
            label: 'Tax ',
            value: model.tax.toStringAsFixed(0),
            isAmount: true,
          ),
          pw.SizedBox(height: 10),
          labelSection(
            label: 'Total ',
            value: model.total.toStringAsFixed(0),
            isAmount: true,
          ),
        ],
      ),
    );
  }

  pw.Container specialNoteSection() {
    return pw.Container(
      width: 250,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: double.infinity,
            color: PdfColor.fromHex("ffdab9"),
            padding: pw.EdgeInsets.all(10),
            child: pw.Text(
              "Special Note",
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            width: double.infinity,
            height: 70,
            color: PdfColor.fromHex("faebd7"),
            padding: pw.EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: pw.Text(
              "",
              style: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void generateInvoice() async {
    pdf.addPage(
      pw.MultiPage(
        // pageTheme: pw.PageTheme(),
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    companySection(),
                    invoiceSection(),
                  ],
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Row(
                  children: [
                    addressSection(
                      width: 200,
                      title: "Bill To",
                      model: AddressModel(
                        addressLine1: "Address Line1",
                        addressLine2: "Address Line 2",
                        district: "Salem",
                        mobileNNumber: "+91 9080823869",
                        pincode: "636003",
                        primaryEmail: "s.abdulkadhar11@gmail.com",
                      ),
                    ),
                    pw.Spacer(),
                    addressSection(
                      title: "Ship To",
                      model: AddressModel(
                        addressLine1: "Address Line1",
                        addressLine2: "Address Line 2",
                        addressLine3: "sample address",
                        district: "Salem",
                        mobileNNumber: "+91 9080823869",
                        pincode: "636003",
                        primaryEmail: "s.abdulkadhar11@gmail.com",
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                tableRow(
                  isHeading: true,
                  detail: ProductDetail(
                    description: "Sample",
                    quantity: 1,
                    unitPrice: 2,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.ListView.separated(
                  itemBuilder: (context, index) => tableRow(
                    detail: ProductDetail(
                      description: "Sample",
                      quantity: 1,
                      unitPrice: 2,
                    ),
                  ),
                  separatorBuilder: (context, index) => pw.SizedBox(height: 10),
                  itemCount: 8,
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    specialNoteSection(),
                    amountDetails(
                      model: AmountModel(
                        discount: 200,
                        subTotal: 400,
                        tax: 23,
                        taxPercent: 1,
                        total: 6000,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ];
        },
      ),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    Random random = new Random();
    int randomNumber = random.nextInt(100);
    File file = File("$documentPath/generated-pdf-$randomNumber.pdf");
    await file.writeAsBytes(
      await pdf.save(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Pdf generated and stored'),
        duration: const Duration(seconds: 5),
      ),
    );
    //PDFDocument loadFile = await PDFDocument.fromFile(file);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          pdfFile: pdf.save(),
        ),
      ),
    );
  }

  void handleGeneratedPdf() async {
    List<File> pdfs = [];
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final fileList = documentDirectory.list();
    fileList.listen((file) async {
      FileStat stat = file.statSync();
      if (stat.type == FileSystemEntityType.file &&
          file.path.endsWith('.pdf')) {
        pdfs.add(File(file.path));
      }
    }).onDone(() {
      print(pdfs.length);
      print(pdfs[0].path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GeneratedPdfPage(
            files: pdfs,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Generate"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: generateInvoice,
              child: Text("Generate Invoice"),
            ),
            ElevatedButton(
              onPressed: handleGeneratedPdf,
              child: Text("Generated Invoices"),
            ),
          ],
        ),
      ),
    );
  }
}
