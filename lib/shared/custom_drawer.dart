import 'package:appdioteste/pages/configuracoes_page.dart';
import 'package:appdioteste/pages/dados_cadastrais.dart';
import 'package:appdioteste/pages/login_page.dart';
import 'package:appdioteste/pages/numeros_aleatorios_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required ListView child});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        context: context, 
                        builder: (BuildContext bc){
                        return Wrap(
                          children: [
                            ListTile(
                              onTap: (){
                                Navigator.pop((context));
                              },
                              title: Text("Camera"),
                              leading: Icon(Icons.camera),
                            ),
                            ListTile(
                              onTap: (){
                                Navigator.pop((context));
                              },
                              title: Text("Galeria"),
                              leading: Icon(Icons.photo_album_rounded),
                            )
                        ],);
                      });
                    },
                    child: UserAccountsDrawerHeader(
                      currentAccountPicture: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/Logo.png"),
                        ),
                      ),
                      accountName: Text("Palla"),
                      accountEmail: Text("palla@gmail.com"),
                      decoration: BoxDecoration(
                        
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
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
              ListTile(
                leading: const Icon(Icons.confirmation_number),
                title: const Text('Gerador de Números Aleatórios'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const NumerosAleatoriosPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gerador de Números Aleatórios selecionado')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configurações'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfiguracoesPage()));
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configurações selecionado')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: () {
                  showDialog(context: context, builder: (BuildContext bc){
                    return AlertDialog(
                      alignment: Alignment.centerLeft,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      title: Text("Meu app"),
                      content: Wrap(
                        children: [
                          Text("Deseja realmente sair do App?"),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }, 
                        child: const Text("Sim")
                        ),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: const Text("Não")
                        )
                      ],
                    );
                  });
                },
              ),
            ],
          ),
        );
  }
}