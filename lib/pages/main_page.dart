import 'package:appdioteste/classes/configuracoes_usuarios.dart';
import 'package:appdioteste/pages/card_page.dart';
import 'package:appdioteste/pages/pagina3.dart';
import 'package:appdioteste/pages/tarefa_page.dart';
import 'package:appdioteste/shared/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  ConfiguracoesUsuario? usuarioConfig;

  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  final chave_nome_usuario = 'chave_nome_usuario';
  final chave_altura = 'chave_altura';
  final chave_receber_notificacao = 'chave_receber_notificacao';
  final chave_tema_escuro = 'chave_tema_escuro';

  @override
  void initState() {
    super.initState();
    _carregarConfiguracoes();
  }

  _carregarConfiguracoes() async {
    final storage = await SharedPreferences.getInstance();

    final nome = storage.getString(chave_nome_usuario) ?? 'Usuário Padrão';
    final altura = storage.getDouble(chave_altura) ?? 0.0;
    final receberNotificacao = storage.getBool(chave_receber_notificacao) ?? false;
    final temaEscuro = storage.getBool(chave_tema_escuro) ?? false;
    setState(() {
      usuarioConfig = ConfiguracoesUsuario(
        nome: nome,
        altura: altura,
        receberNotificacao: receberNotificacao,
        temaEscuro: temaEscuro,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Main Page")),
        drawer: CustomDrawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Fecha o Drawer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Home selecionado')),
                  );
                },
              ),
            ],
          ),
        ),
        body: PageView(
          controller: controller,
          onPageChanged: (value){
            setState(() {
              posicaoPagina = value;
            });
          },
          children: [
            CardPage(
              nome: usuarioConfig?.nome ?? "Nome Padrão",
              dataNascimento: DateTime(1990, 5, 12),
              altura: usuarioConfig?.altura ?? 170.0,
              nivel: "Sênior",
              linguagens: ["Dart", "Flutter"],
              salario: 8000,
              tempoExperiencia: 5,
            ),
            TarefaPage(),
            Pagina3(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            controller.jumpToPage(value);
          },
          currentIndex: posicaoPagina, items: [
            BottomNavigationBarItem(
              label: "Pag1",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Tarefas",
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: "Pag3",
              icon: Icon(Icons.settings),
            ),
        ]),
      ),
    );
  }
}
