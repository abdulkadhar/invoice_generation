import 'package:flutter/material.dart';
import 'package:invoice_generate/model/address_model.dart';
import 'package:invoice_generate/widgets/form_text_field.dart';
import 'package:invoice_generate/widgets/intermediate_title.dart';
import 'package:validators/validators.dart';

class AddressCollectionForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(AddressModel) getAddressData;
  final String label;
  const AddressCollectionForm({
    Key? key,
    required this.formKey,
    required this.getAddressData,
    required this.label,
  }) : super(key: key);

  @override
  _AddressCollectionFormState createState() => _AddressCollectionFormState();
}

class _AddressCollectionFormState extends State<AddressCollectionForm> {
  late String _addressLine1;

  late String _addressLine2;

  late String _district;

  late String _mobileNNumber;

  late String _pincode;

  late String _primaryEmail;

  late String _addressLine3;

  late String _secondaryEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            IntermediateTitle(title: "Company Address Details"),
            LabeledTextField(
              labelName: "Address Line 1",
              onSaved: (line1) {
                final currentValue = line1;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _addressLine1 = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Address Line 2",
              onSaved: (line2) {
                final currentValue = line2;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _addressLine2 = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Address Line 3",
              required: false,
              onSaved: (line3) {
                _addressLine3 = line3 ?? "";
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "District",
              onSaved: (district) {
                final currentValue = district;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _district = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Mobile Phone Number",
              isNumber: true,
              maxLength: 10,
              validator: (value) {
                if (value != null) {
                  if (value.length < 10) {
                    return "Please enter a valid phone number";
                  }
                }
              },
              onSaved: (phone) {
                final currentValue = phone;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _mobileNNumber = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Pincode",
              isNumber: true,
              maxLength: 6,
              validator: (value) {
                if (value != null) {
                  if (value.length < 6) {
                    return "Please enter a valid pincode";
                  }
                }
              },
              onSaved: (code) {
                final currentValue = code;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _pincode = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Primary Email",
              validator: (email) {
                final currentEmail = email;

                if (currentEmail != null && !isEmail(currentEmail)) {
                  return "Please enter a vaid email";
                }
                return null;
              },
              onSaved: (email) {
                final currentValue = email;
                if (currentValue != null && currentValue.isNotEmpty) {
                  _primaryEmail = currentValue;
                }
              },
            ),
            const SizedBox(height: 10),
            LabeledTextField(
              labelName: "Secondary Email",
              required: false,
              validator: (email) {
                final currentEmail = email;
                if (currentEmail == null || currentEmail.isEmpty) {
                  return null;
                }
                if (!isEmail(currentEmail)) {
                  return "Please enter a valid email";
                }
              },
              onSaved: (email) {
                _secondaryEmail = email ?? "";
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final _currentState = widget.formKey.currentState;
                if (_currentState != null && _currentState.validate()) {
                  _currentState.save();
                  final AddressModel _data = AddressModel(
                    addressLine1: _addressLine1,
                    addressLine2: _addressLine2,
                    district: _district,
                    mobileNNumber: _mobileNNumber,
                    pincode: _pincode,
                    primaryEmail: _primaryEmail,
                    addressLine3: _addressLine3,
                    secondaryEmail: _secondaryEmail,
                  );
                  widget.getAddressData(_data);
                  return;
                }
                print("It doesnt pass the validate methods");
              },
              child: Text(
                "Generate Invoice",
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
