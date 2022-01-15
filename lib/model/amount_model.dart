class AmountModel {
  final double subTotal;
  final double discount;
  final double taxPercent;
  final double tax;
  final double total;

  AmountModel({
    required this.discount,
    required this.subTotal,
    required this.tax,
    required this.taxPercent,
    required this.total,
  });
}
