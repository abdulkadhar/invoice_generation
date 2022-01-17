import 'package:flutter/material.dart';

class InvoiceFormScreen extends StatefulWidget {
  const InvoiceFormScreen({Key? key}) : super(key: key);

  @override
  _InvoiceFormScreenState createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Invoice Generate",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
