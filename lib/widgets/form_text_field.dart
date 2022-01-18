import 'package:flutter/material.dart';

class LabeledTextField extends StatefulWidget {
  final String labelName;
  final bool required;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool isNumber;
  final int? maxLength;
  const LabeledTextField({
    Key? key,
    required this.labelName,
    this.required = true,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.isNumber = false,
    this.maxLength,
  }) : super(key: key);

  @override
  _LabeledTextFieldState createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.labelName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              if (widget.required)
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    "*",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            maxLength: widget.maxLength,
            keyboardType:
                widget.isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
            ),
            cursorColor: Colors.grey,
            validator: (validate) {
              final value = widget.validator;
              if (widget.required) {
                if (validate == null || validate.isEmpty) {
                  return " ${widget.labelName} is Required.";
                }
              }
              if (value != null) {
                return value(validate);
              }
            },
            onSaved: widget.onSaved,
          )
        ],
      ),
    );
  }
}
