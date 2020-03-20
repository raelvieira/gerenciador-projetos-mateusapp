import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerenciador_projetos_app/models/tarefa_projeto.dart';
import 'package:gerenciador_projetos_app/repositories/tarefa_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeTarefaBloc extends BlocBase {
  final TarefaRepository _repository;

  BehaviorSubject<List<TarefaProjeto>> _tarefasController = BehaviorSubject<List<TarefaProjeto>>();
  BehaviorSubject<String> _tituloTarefaProjetoController = BehaviorSubject<String>();

  HomeTarefaBloc(this._repository);

  Stream<String> get outTitulo =>  _tituloTarefaProjetoController.stream;
  Stream<List<TarefaProjeto>> get outTarefas => _tarefasController.stream;

  Function(String) get changeTitulo => _tituloTarefaProjetoController.sink.add;

  void getTarefas(int projetoId) async {
    try {
      var resposta = await _repository.getProjetos(projetoId);
      _tarefasController.sink.add(resposta);
    }catch(e) {
      _tarefasController.addError(e);
    }
  }

  Future<int> salvarTarefa(int projetoId) async {
    try {
      return _repository.criarTarefa(_getTarefa().toJson(projetoId));
    }catch(e) {
      print(e);
    }
  }

  Future<int> finalizarTarefa(int tarefaId) async {
    try{
      return _repository.finalizarTarefa(tarefaId);
    }catch(e) {
      print(e);
    }
  }

  TarefaProjeto _getTarefa() {
    return TarefaProjeto(
      titulo: _tituloTarefaProjetoController.value
    );
  }

  @override
  void dispose() {
    _tarefasController.close();
    _tituloTarefaProjetoController.close();
  }
}