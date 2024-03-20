import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(width: 100,
          height: 100,
          child: Image.asset(
              "assets/icons/web_icon.png", height: 100, width: 100,),),
        const SizedBox(height: 10,),
        Text(
          text ?? "ว่างเปล่า",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Bai',
          ),
        )
      ],
    );
  }
}