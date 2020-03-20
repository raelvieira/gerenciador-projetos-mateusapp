import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerenciador_projetos_app/repositories/projeto_repository.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final ProjetoRepository _repository;
  BehaviorSubject<List<Projeto>> _projetosController = BehaviorSubject<List<Projeto>>();

  HomeBloc(this._repository);

  Stream<List<Projeto>> get outProjetos => _projetosController.stream;

  void getProjetos() async {
    try {
      var resposta = await _repository.getProjetos();
      _projetosController.sink.add(resposta);
    }catch(e) {
      _projetosController.addError(e);
    }
  }

  Future<int> finalizarProjeto(int projetoId) async {
    try{
      return _repository.finalizarProjeto(projetoId);
    }catch(e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _projetosController.close();
  }
}