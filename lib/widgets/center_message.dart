import 'package:flutter/material.dart';

class CenterMessage extends StatelessWidget {
  final String text;
  const CenterMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(text,
            style: const TextStyle(fontSize: 20, fontFamily: 'Exo 2')));
  }
}
