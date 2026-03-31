import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Display extends StatelessWidget {
  final String text;

  const Display({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(20),
      child: Text(
        text.isEmpty ? "0" : text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}