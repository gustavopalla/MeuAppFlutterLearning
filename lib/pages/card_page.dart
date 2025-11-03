import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardPage extends StatefulWidget {
  final String nome;
  final double altura;
  final DateTime dataNascimento;
  final String nivel;
  final List<String> linguagens;
  final int salario;
  final int tempoExperiencia;

  const CardPage({
    super.key,
    required this.nome,
    required this.dataNascimento,
    required this.nivel,
    required this.linguagens,
    required this.salario,
    required this.tempoExperiencia,
    required this.altura,
  });

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {

  String nomeUsuario = 'João Silva';
  double alturaUsuario = 0.0;

  final String chave_nome_usuario = 'chave_nome_usuario';
  final String chave_altura = 'chave_altura';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserConfig();
  }

  Future<void> _loadUserConfig() async {
    final storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = storage.getString(chave_nome_usuario) ?? 'Usuário Padrão';
      alturaUsuario = storage.getDouble(chave_altura) ?? 0.0;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: double.infinity,
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alinha à esquerda
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Nome: ${widget.nome}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Altura: ${widget.altura}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Nascimento: ${widget.dataNascimento.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Nível: ${widget.nivel}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Linguagens: ${widget.linguagens.join(', ')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Experiência: ${widget.tempoExperiencia} anos",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        "Pretensão Salarial: R\$ ${widget.salario}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
