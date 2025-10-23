import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        );
  }
}