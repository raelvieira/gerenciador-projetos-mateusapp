import 'package:dio/dio.dart';
import 'package:gerenciador_projetos_app/models/tarefa_projeto.dart';
import 'package:gerenciador_projetos_app/shared/custom_dio/custom_dio.dart';

class TarefaRepository {
  final CustomDio _client;

  TarefaRepository(this._client);

  Future<List<TarefaProjeto>> getProjetos(int projetoId) async {
    try {
      var response = await _client.get('tarefa?projetoId=${projetoId}');
      return response.data['content'].map<TarefaProjeto>( (tarefa) => TarefaProjeto.fromJson(tarefa)).toList();
    }on DioError catch(e) {
      print(e);
      throw(e.response);
    }
  }

  Future<int> criarTarefa(Map<String, dynamic> data) async {
    try {
      var response = await _client.post('tarefa', data: data);
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }

  Future<int> finalizarTarefa(int tarefaId) async {
    try{
      var response = await _client.put('tarefa/finalizar/${tarefaId}');
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }
}