import 'package:flutter/material.dart';

class custumTextFeild extends StatelessWidget{
  final controller;
  final hint;
  String? Function(String?)? validator;

  custumTextFeild({
    required this.hint,
    this.controller,
    required this.validator,
});

  @override
  Widget build(BuildContext context) {

    return  TextFormField(
    validator:validator ,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEEEEEE),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }






}