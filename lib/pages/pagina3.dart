import 'package:flutter/material.dart';

class Pagina3 extends StatefulWidget {
  const Pagina3({super.key});

  @override
  State<Pagina3> createState() => _Pagina3State();
}

class _Pagina3State extends State<Pagina3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
              color: Colors.white,
              child: Center(
                child: Text('Página 3', style: TextStyle(fontSize: 24),),
                )
              ),
    );
  }
}