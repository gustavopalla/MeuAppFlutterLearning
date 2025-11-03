import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {

  late SharedPreferences storage;

  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberNotificacao = false;
  bool temaEscuro = false;
  
  final chave_nome_usuario = 'chave_nome_usuario';
  final chave_altura = 'chave_altura';
  final chave_receber_notificacao = 'chave_receber_notificacao';
  final chave_tema_escuro = 'chave_tema_escuro';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = storage.getString(chave_nome_usuario) ?? '';
      altura = storage.getDouble(chave_altura) ?? 0.0;
      receberNotificacao = storage.getBool(chave_receber_notificacao) ?? false;
      temaEscuro = storage.getBool(chave_tema_escuro) ?? false;
      nomeController.text = nomeUsuario!;
      alturaController.text = altura.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: nomeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Usuário',
                      hintText: 'Digite seu nome',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: alturaController,
                    decoration: const InputDecoration(
                      labelText: 'Altura',
                      hintText: 'Digite sua altura em cm',
                    ),
                  ),
                ),
                SwitchListTile(
                  title: const Text('Receber Notificações'),
                  value: receberNotificacao,
                  onChanged: (bool valor) {
                    setState(() {
                      receberNotificacao = valor;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Tema Escuro'),
                  value: temaEscuro,
                  onChanged: (bool valor) {
                    setState(() {
                      temaEscuro = valor;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4.0,
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () async { // salva os dados da configuração
                          await storage.setString(chave_nome_usuario, nomeController.text);
                          await storage.setDouble(chave_altura, double.tryParse(alturaController.text) ?? 0.0);
                          await storage.setBool(chave_receber_notificacao, receberNotificacao);
                          await storage.setBool(chave_tema_escuro, temaEscuro);
                  
                          Navigator.pop(context);
                  
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Configurações salvas com sucesso!'),
                            ),
                          );
                        },
                        child: const Text('Salvar')
                        ),
                    ),
                  ),
                )
              ]
            ),
          ),
        ),
      ));
  }
}