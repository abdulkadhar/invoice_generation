import 'package:flutter/material.dart';
import 'package:invoice_generate/model/page_model.dart';
import 'package:invoice_generate/screen/invoice_form_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<PageModel>(
      create: (context) => PageModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageModel>(
      create: (context) => PageModel(),
      child: MaterialApp(
        title: 'Invoice Generation',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InvoiceFormScreen(),
        //home: InvoiceCreation(),
      ),
    );
  }
}
