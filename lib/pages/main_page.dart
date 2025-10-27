import 'package:appdioteste/pages/dados_cadastrais.dart';
import 'package:appdioteste/pages/card_page.dart';
import 'package:appdioteste/pages/pagina3.dart';
import 'package:appdioteste/pages/tarefa_page.dart';
import 'package:appdioteste/shared/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
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
              ListTile(
                leading: const Icon(Icons.data_usage),
                title: const Text('Dados Cadastrais'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DadosCadastrais()));
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados Cadastrais selecionado')),
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
              nome: "João Silva",
              dataNascimento: DateTime(1990, 5, 12),
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
