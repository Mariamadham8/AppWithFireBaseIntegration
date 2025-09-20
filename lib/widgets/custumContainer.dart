import 'package:flutter/material.dart';

class custuMcontainer extends StatelessWidget{

  final Icon icon;

  const custuMcontainer({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
          shape:BoxShape.rectangle ,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius:BorderRadius.circular(10)
      ),
      child: icon,
    );

  }

}