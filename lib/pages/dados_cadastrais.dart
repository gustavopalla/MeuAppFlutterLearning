import 'package:appdioteste/pages/main_page.dart';
import 'package:appdioteste/repository/linguagens_repository.dart';
import 'package:appdioteste/repository/nivel_repository.dart';
import 'package:appdioteste/shared/widgets/text_label.dart';
import 'package:appdioteste/shared/widgets/text_label_salario.dart';
import 'package:flutter/material.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController datanascController = TextEditingController(text: "");
  DateTime? dataNascimento;

  var nivelRepository = NivelRepository();
  var linguagensRepository = LinguagensRepository();

  var niveis = [];
  var nivelSelecionado = "";

  var linguagens = [];
  var linguagensSelecionadas = [];

  double salarioEscolhido = 0;
  int tempoExperciencia = 0;

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  List<DropdownMenuItem> returnItens(int quantidadeMaxima) {
    var items = <DropdownMenuItem>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const SizedBox(height: 10),
                  const TextLabel(texto: "Data de nascimento"),
                  TextField(
                    controller: datanascController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2025, 1, 1),
                        firstDate: DateTime(1900, 1, 1),
                        lastDate: DateTime(2025, 10, 1),
                      );
                      if (data != null) {
                        setState(() {
                          datanascController.text = data.toString();
                          dataNascimento = data;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextLabel(texto: "Nível de experiência"),
                  Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                              title: Text(nivel.toString()),
                              selected: nivelSelecionado == nivel,
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  nivelSelecionado = value.toString();
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(texto: "Linguagens Preferidas"),
                  Column(
                    children: linguagens
                        .map((linguagem) => CheckboxListTile(
                              title: Text(linguagem),
                              value: linguagensSelecionadas.contains(linguagem),
                              onChanged: (bool? value) {
                                if (value!) {
                                  setState(() {
                                    linguagensSelecionadas.add(linguagem);
                                  });
                                } else {
                                  setState(() {
                                    linguagensSelecionadas.remove(linguagem);
                                  });
                                }
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(texto: "Tempo de Experiência"),
                  DropdownButton(
                    value: tempoExperciencia,
                    isExpanded: true,
                    items: returnItens(50),
                    onChanged: (value) {
                      setState(() {
                        tempoExperciencia = int.parse(value.toString());
                      });
                    },
                  ),
                  const TextLabel(texto: "Pretenção Salarial"),
                  TextLabelSalario(
                      texto: "R\$ ${salarioEscolhido.round().toString()}"),
                  Slider(
                    min: 0,
                    max: 100000,
                    value: salarioEscolhido,
                    onChanged: (double value) {
                      setState(() {
                        salarioEscolhido = value;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("O nome deve ser preenchido corretamente"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (dataNascimento == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Data de nascimento vazia ou inválida"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (nivelSelecionado.trim() == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("O nível deve ser selecionado"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (linguagensSelecionadas.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Deve ser selecionada ao menos uma linguagem"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (tempoExperciencia == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Deve ter ao menos 1 ano de experiência"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      if (salarioEscolhido == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("A pretenção salarial deve ser maior que 0"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      

                      
                      setState(() {
                        salvando = true;
                      });
                      
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Salvo com sucesso!"),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      
                      print(nomeController.text);
                      print(dataNascimento);
                      print(linguagensSelecionadas);
                      print(salarioEscolhido.round());
                      print(nivelSelecionado);
                      print(tempoExperciencia);

                      
                      Future.delayed(const Duration(seconds: 1), () {

                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                        }
                      });
                    }, 
                    child: const Text("Salvar"),
                  ), 
                ],
              ),
      ),
    );
  }
}