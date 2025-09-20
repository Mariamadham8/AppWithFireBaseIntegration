import 'package:flutter/material.dart';

class CustomAlign extends StatelessWidget {
  final String label;
  final Color color;
  final double  fontsize;

  const CustomAlign({
    super.key,
    required this.label,
    required this.color,
    required this.fontsize
  });

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontsize,
        ),
      ),
    );
  }
}
