import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerenciador_projetos_app/repositories/projeto_repository.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:rxdart/rxdart.dart';

class EditarBloc extends BlocBase {
  final ProjetoRepository _repository;

  BehaviorSubject<String> _tituloProjetoController = BehaviorSubject<String>();
  BehaviorSubject<String> _descricaoProjetoController = BehaviorSubject<String>();
  BehaviorSubject<DateTime> _dataPrevisaoEntregaController = BehaviorSubject<DateTime>();

  EditarBloc(this._repository);

  Stream<String> get outTitulo =>  _tituloProjetoController.stream;
  Stream<String> get outDescricao =>  _descricaoProjetoController.stream;
  Stream<DateTime> get outPrevisaoEntrega =>  _dataPrevisaoEntregaController.stream;

  Function(String) get changeTitulo => _tituloProjetoController.sink.add;
  Function(String) get changeDescricao => _descricaoProjetoController.sink.add;
  Function(DateTime) get changePrevisaoEntrega => _dataPrevisaoEntregaController.sink.add;

  Stream<bool> get outSubmitValido => Observable.combineLatest2(
    outTitulo,
    outPrevisaoEntrega,
    (a, b) => true
  );

  Future<int> editarProjeto(int projetoId) {
    if(_dataPrevisaoEntregaController.value.isBefore(DateTime.now()))
      return Future.value(-1);

    try {
      return _repository.editarProjeto(_getProjeto().toJson(), projetoId);
    }catch(e) {
      print(e);
    }
  }

  Future<int> excluirProjeto(int projetoId) {
    try {
      return _repository.excluirProjeto(projetoId);
    }catch(e) {
      print(e);
    }
  }

  Projeto _getProjeto() {
    return Projeto(
        titulo: _tituloProjetoController.value,
        descricao: _descricaoProjetoController.value,
        dataPrevisaoEntrega: _dataPrevisaoEntregaController.value,
    );
  }

  @override
  void dispose() {
    _tituloProjetoController.close();
    _descricaoProjetoController.close();
    _dataPrevisaoEntregaController.close();
  }
}