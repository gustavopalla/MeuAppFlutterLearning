import 'package:flutter/material.dart';

class TextLabelSalario extends StatelessWidget {
  final String texto;
  const TextLabelSalario({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(texto, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.green))
      );
  }
}