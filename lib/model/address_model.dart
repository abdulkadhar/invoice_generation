class AddressModel {
  final String addressLine1;
  final String addressLine2;
  final String addressLine3;
  final String district;
  final String pincode;
  final String mobileNNumber;
  final String primaryEmail;
  final String secondaryEmail;

  AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    this.addressLine3 = "",
    required this.district,
    required this.mobileNNumber,
    required this.pincode,
    required this.primaryEmail,
    this.secondaryEmail = "",
  });
}
