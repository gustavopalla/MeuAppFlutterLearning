import 'package:flutter/material.dart';

class Pagina2 extends StatefulWidget {
  const Pagina2({super.key});

  @override
  State<Pagina2> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Text('Página 2', style: TextStyle(fontSize: 24),),
                )
              ),
    );
  }
}