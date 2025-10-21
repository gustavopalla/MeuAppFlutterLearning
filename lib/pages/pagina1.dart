import 'package:flutter/material.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _Pagina2State();
}

class _Pagina2State extends State<Pagina1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Text('Página 1', style: TextStyle(fontSize: 24),),
                )
              ),
    );
  }
}