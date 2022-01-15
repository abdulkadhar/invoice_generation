import 'package:flutter/material.dart';
import 'package:invoice_generate/screen/invoice_creation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice Generation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InvoiceCreation(),
    );
  }
}
