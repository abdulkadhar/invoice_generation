import 'package:invoice_generate/model/address_model.dart';
import 'package:invoice_generate/model/invoice_info_model.dart';
import 'package:invoice_generate/model/product_detail_model.dart';

class InvoiceModel {
  final String companyName;
  final AddressModel companyAddress;
  final InvoiceInfoModel invoiceData;
  final AddressModel billToInfo;
  final AddressModel shipToInfo;
  final List<ProductDetail> products;
  final String specialNote;
  final double subTotal;
  final double discount;
  final double taxRate;
  final double taxAmount;
  final double total;

  InvoiceModel({
    required this.companyName,
    required this.companyAddress,
    required this.invoiceData,
    required this.billToInfo,
    required this.shipToInfo,
    required this.products,
    this.specialNote = "",
    required this.subTotal,
    required this.discount,
    required this.taxRate,
    required this.taxAmount,
    required this.total,
  });
}
