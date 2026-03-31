import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int flex;

  const CalcButton({
    super.key,
    required this.text,
    required this.onTap,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;

    if (text == "=") {
      bgColor = Colors.orange;
    } else if (['+', '-', '*', '/', '%'].contains(text)) {
      bgColor = Colors.blueGrey;
    } else {
      bgColor = Colors.grey[850]!;
    }

    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(6),
          constraints: BoxConstraints(
            minHeight: 48,
            minWidth: 48,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}