import 'package:flutter/material.dart';
import 'package:market_peace/constants.dart';

class CustomFormField extends StatelessWidget {
  final String formType;
  final TextEditingController controller;
  final bool obscureText;
  final bool isRequired;

  const CustomFormField({
    Key? key,
    required this.formType,
    required this.controller,
    this.isRequired  = true,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        obscureText: obscureText,
        validator: (value) {
          if(isRequired){
            if (value == null || value == "") {
              return "Veuillez insérer une $formType";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(
            "$formType ${isRequired ? "(Obligatoire)" : ""}",
            style: const TextStyle(
              color: darkAccentuation,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
