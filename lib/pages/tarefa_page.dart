import 'package:appdioteste/model/tarefa.dart';
import 'package:appdioteste/repository/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = <Tarefa>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluidas = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async{
    if(apenasNaoConcluidas){
      _tarefas =  await tarefaRepository.listarNaoConcluidas();
      setState(() {});
      return;
    }else{
      _tarefas =  await tarefaRepository.listar();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add),
        onPressed: (){
          descricaoController.text = "";
          showDialog(context: context, builder: (BuildContext bc){
            return AlertDialog(
              title: Text("Adicionar Tarefa"),
              content: TextField(
                decoration: InputDecoration(hintText: "Digite o nome da tarefa"),
                controller: descricaoController,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(bc).pop();
                  },
                ),
                TextButton(
                  child: Text("Adicionar"),
                  onPressed: () async{
                    await tarefaRepository.adicionarTarefa(Tarefa(descricaoController.text, false));
                    Navigator.of(bc).pop();
                    setState(() {
                      obterTarefas();
                    });
                  },
                ),
              ],
            );
          });
      }),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filtrar Tarefas não concluídas", style: TextStyle(fontSize: 16),),
                  Switch(
                    value: apenasNaoConcluidas, 
                    onChanged: (bool value){
                      setState(() {
                        apenasNaoConcluidas = value;
                        obterTarefas();
                      });
                    }
                    )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    key: Key(tarefa.getId()),
                    onDismissed: (direction) async {
                      await tarefaRepository.remove(tarefa.getId());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tarefa '${tarefa.getDescricao()}' removida"))
                      );
                      setState(() {
                        obterTarefas();
                      });
                    },
                    child: ListTile(
                      title: Text(tarefa.getDescricao()),
                      trailing: Switch(
                      value: tarefa.getConcluido(), 
                      onChanged: (bool value) async{
                        await tarefaRepository.alterar(tarefa.getId(), value);
                        setState(() {
                          obterTarefas();
                        });
                      }),
                    ),
                  );
              }
                  ),
            ),
          ],
        ),
      ));
  }
}