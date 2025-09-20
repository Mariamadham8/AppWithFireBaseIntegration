import 'package:flutter/material.dart';

class custumTextFeild extends StatelessWidget{
  final controller;
  final hint;

  custumTextFeild({
    required this.hint,
    this.controller
});

  @override
  Widget build(BuildContext context) {

    return  TextField(
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