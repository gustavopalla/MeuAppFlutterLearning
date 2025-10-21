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

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: ListView(
          children: [
            TextLabel(texto: "Nome"),
            TextField(
              controller: nomeController,
            ),
            SizedBox(height: 10),
            TextLabel(texto: "Data de nascimento"),
            TextField(
              controller: datanascController,
              readOnly: true,
              onTap: () async {
                var data = await showDatePicker(
                  context: context, initialDate: DateTime(2025,1,1),firstDate: DateTime(1900,1,1), lastDate: DateTime(2025, 10, 1)
                  );
                  if(data!=null){
                    datanascController.text = data.toString();
                    dataNascimento = data;
                  }
              },
            ),
            SizedBox(height: 10,),
            const TextLabel(texto: "Nível de experiência"),
            Column(children: niveis
            .map((nivel) => RadioListTile(
              title: Text(nivel.toString()),
              selected: nivelSelecionado == nivel,
              value: nivel.toString(), 
              groupValue: nivelSelecionado,
              onChanged: (value){
                setState(() {
                  print(value);
                  nivelSelecionado = value.toString();
                });
              },
              )).toList(),),

            const TextLabel(texto: "Linguagens Preferidas"),

            Column(children: linguagens.map((linguagem) => CheckboxListTile(
              title: Text(linguagem),
              value: linguagensSelecionadas.contains(linguagem), 
              onChanged: (bool? value){
                if(value!){
                  setState(() {
                    linguagensSelecionadas.add(linguagem);
                  });
                } else{
                  setState(() {
                    linguagensSelecionadas.remove(linguagem);
                  });
                }
              })
              ).toList(),),

            TextLabel(texto: "Pretenção Salarial"),
            TextLabelSalario(texto: "R\$ ${salarioEscolhido.round().toString()}"),
            Slider(
            min: 0,
            max: 100000,
            value: salarioEscolhido,
            onChanged: (double value){
              setState(() {
                salarioEscolhido = value;
              });
            }),

            TextButton(onPressed: (){
             print(nomeController.text);
             print(dataNascimento);
            }, 
            child: Text("Salvar"))
          ],
        ),
      ),
    );
  }
}