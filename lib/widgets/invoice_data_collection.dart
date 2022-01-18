import 'package:flutter/material.dart';
import 'package:invoice_generate/model/invoice_info_model.dart';
import 'package:invoice_generate/widgets/form_text_field.dart';
import 'package:invoice_generate/widgets/intermediate_title.dart';

class InvoiceInfoCollection extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final Function(InvoiceInfoModel) getInvoiceInfoData;

  const InvoiceInfoCollection({
    Key? key,
    required this.title,
    required this.formKey,
    required this.getInvoiceInfoData,
  }) : super(key: key);

  @override
  State<InvoiceInfoCollection> createState() => _InvoiceInfoCollectionState();
}

class _InvoiceInfoCollectionState extends State<InvoiceInfoCollection> {
  late String _purchaseOrderNumber;

  late String _paymentOrderNumber;

  late String _invoiceId;

  late String _invoiceDate;

  late String _customerId;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            IntermediateTitle(title: widget.title),
            LabeledTextField(
              labelName: "Customer Id",
              onSaved: (id) {
                final currentValue = id;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _customerId = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Invoice Date",
              onSaved: (date) {
                final currentValue = date;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _invoiceDate = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Invoice ID",
              onSaved: (id) {
                final currentValue = id;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _invoiceId = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Payment Order Number",
              onSaved: (pon) {
                final currentValue = pon;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _paymentOrderNumber = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Purchase Order Number",
              isNumber: true,
              maxLength: 10,
              onSaved: (number) {
                final currentValue = number;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _purchaseOrderNumber = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final _currentState = widget.formKey.currentState;
                if (_currentState != null && _currentState.validate()) {
                  _currentState.save();
                  final InvoiceInfoModel _data = InvoiceInfoModel(
                      customerId: _customerId,
                      invoiceDate: DateTime.now(),
                      invoiceId: _invoiceId,
                      paymentOrderNumber: _paymentOrderNumber,
                      purchaseOrderNumber: _purchaseOrderNumber);
                  widget.getInvoiceInfoData(_data);
                  return;
                }
              },
              child: Text(
                "Submit Invoice Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
