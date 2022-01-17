class InvoiceInfoModel {
  final DateTime invoiceDate;
  final String invoiceId;
  final String customerId;
  final String purchaseOrderNumber;
  final String paymentOrderNumber;

  InvoiceInfoModel({
    required this.customerId,
    required this.invoiceDate,
    required this.invoiceId,
    required this.paymentOrderNumber,
    required this.purchaseOrderNumber,
  });
}
