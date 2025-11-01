import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  
  int numeroGerado = 0;
  int? quantidadeCliques = 0;
  final chave_numero = "numero_aleatorio";
  final chave_cliques = "quantidade_cliques";
  late final SharedPreferences storage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();

  }

  void carregarDados() async{
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(chave_numero) ?? 0;
      quantidadeCliques = storage.getInt(chave_cliques) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de Números Aleatórios'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Número Aleatório Gerado:", style: TextStyle(fontSize: 20),),
              Text(numeroGerado.toString(), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w400),),
              Text(quantidadeCliques.toString(), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            setState(() {
              var random = new Random();
              numeroGerado = random.nextInt(1000);
              quantidadeCliques = (quantidadeCliques ?? 0) + 1;
            });
            storage.setInt(chave_numero, numeroGerado);
            storage.setInt(chave_cliques, quantidadeCliques!);
            var numero = storage.getInt(chave_numero);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}