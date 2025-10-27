import 'package:appdioteste/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    await Future.delayed(Duration(seconds: 1));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
      await Future.delayed(Duration(milliseconds: 0));
      _tarefas.where((tarefa) => tarefa.getId() == id).first.setConcluido(concluido);
  }

  Future<List<Tarefa>> getTarefas() async {
    await Future.delayed(Duration(seconds: 2));
    return _tarefas;
  }

  Future<List<Tarefa>> listar() async {
    await Future.delayed(Duration(milliseconds: 0));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluidas() async {
    await Future.delayed(Duration(milliseconds: 0));
    return _tarefas.where((tarefa) => !tarefa.getConcluido()).toList();
  }

  Future<void> remove(String id) async {
      await Future.delayed(Duration(milliseconds: 0));
      _tarefas.removeWhere((tarefa) => tarefa.getId() == id);
  }

}