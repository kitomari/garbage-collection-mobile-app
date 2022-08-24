import 'package:flutter/material.dart';

class CustomTextInpuField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextInpuField({ Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Enter your $hintText";
        }
        return null;
      },
    );
  }
}