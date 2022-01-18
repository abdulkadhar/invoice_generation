import 'package:flutter/material.dart';
import 'package:invoice_generate/model/address_model.dart';
import 'package:invoice_generate/model/invoice_info_model.dart';
import 'package:invoice_generate/model/invoice_model.dart';
import 'package:invoice_generate/model/page_model.dart';
import 'package:invoice_generate/product_list_model.dart';
import 'package:invoice_generate/widgets/address_collection_form.dart';
import 'package:invoice_generate/widgets/form_text_field.dart';
import 'package:invoice_generate/widgets/intermediate_title.dart';
import 'package:invoice_generate/widgets/invoice_data_collection.dart';
import 'package:invoice_generate/widgets/product_list_initial.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class InvoiceFormScreen extends StatefulWidget {
  const InvoiceFormScreen({Key? key}) : super(key: key);

  @override
  _InvoiceFormScreenState createState() => _InvoiceFormScreenState();
}

class _InvoiceFormScreenState extends State<InvoiceFormScreen> {
  final GlobalKey<FormState> _companyNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _companyAddressDataKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _billToAddressDataKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _shipToAddressDataKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _invoiceDataKey = GlobalKey<FormState>();
  PageController _invoiceController = PageController();
  late InvoiceModel _formdata;

  late String _name;
  late AddressModel _companyAddress;
  late AddressModel _billToAddress;
  late AddressModel _shipToAddress;
  late InvoiceInfoModel _invoiceData;

  Widget _getCompanyName() {
    return Form(
      key: _companyNameKey,
      child: Column(
        children: [
          const SizedBox(height: 15),
          LabeledTextField(
            labelName: "Company Name",
            onSaved: (name) {
              final currentValue = name;
              if (currentValue != null && currentValue.isNotEmpty) {
                _name = currentValue;
              }
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              final currentState = _companyNameKey.currentState;
              if (currentState != null && currentState.validate()) {
                currentState.save();
                _invoiceController.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeOutQuart,
                );
                final pageModel =
                    Provider.of<PageModel>(context, listen: false);

                if (_invoiceController.page != null)
                  pageModel.increasePageNumber();
              }
            },
            child: Text(
              "Submit name",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Consumer<PageModel>(builder: (context, pageModel, child) {
          return Text(
            "Invoice Generate ${pageModel.pageNumber.toStringAsFixed(0)}/",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          );
        }),
      ),
      body: PageView(
        controller: _invoiceController,
        children: [
          _getCompanyName(),
          AddressCollectionForm(
            formKey: _companyAddressDataKey,
            getAddressData: (value) {
              _companyAddress = value;
              _invoiceController.nextPage(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.easeOutQuart,
              );
              final pageModel = Provider.of<PageModel>(context, listen: false);

              if (_invoiceController.page != null)
                pageModel.increasePageNumber();
            },
            label: "Company Address Details",
          ),
          InvoiceInfoCollection(
            title: "Invoice Info Details",
            formKey: _invoiceDataKey,
            getInvoiceInfoData: (data) {
              _invoiceData = data;
              _invoiceController.nextPage(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.easeOutQuart,
              );
              final pageModel = Provider.of<PageModel>(context, listen: false);

              if (_invoiceController.page != null)
                pageModel.increasePageNumber();
            },
          ),
          AddressCollectionForm(
            formKey: _billToAddressDataKey,
            getAddressData: (value) {
              _billToAddress = value;
              _invoiceController.nextPage(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.easeOutQuart,
              );
              final pageModel = Provider.of<PageModel>(context, listen: false);

              if (_invoiceController.page != null)
                pageModel.increasePageNumber();
            },
            label: "Billing to Address details",
          ),
          AddressCollectionForm(
            formKey: _shipToAddressDataKey,
            getAddressData: (value) {
              _shipToAddress = value;
              _invoiceController.nextPage(
                duration: Duration(
                  seconds: 1,
                ),
                curve: Curves.easeOutQuart,
              );
              final pageModel = Provider.of<PageModel>(context, listen: false);

              if (_invoiceController.page != null)
                pageModel.increasePageNumber();
            },
            label: "Ship to Address Details",
          ),
          ChangeNotifierProvider<ProductListModel>(
            create: (context) => ProductListModel(),
            child: ProductListHolder(
              title: "Product List",
            ),
          )
        ],
      ),
    );
  }
}
