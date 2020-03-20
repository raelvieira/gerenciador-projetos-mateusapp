import 'package:dio/dio.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:gerenciador_projetos_app/shared/custom_dio/custom_dio.dart';

class ProjetoRepository {
  final CustomDio _client;

  ProjetoRepository(this._client);

  Future<List<Projeto>> getProjetos() async {
    try {
      var response = await _client.get('projeto');
      return response.data['content'].map<Projeto>( (projeto) => Projeto.fromJson(projeto)).toList();
    }on DioError catch(e) {
      print(e);
      throw(e.response);
    }
  }

  Future<int> criarProjeto(Map<String, dynamic> data) async {
    try {
      var response = await _client.post('projeto', data: data);
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }

  Future<int> finalizarProjeto(int projetoId) async {
    try{
      var response = await _client.put('projeto/finalizar/${projetoId}');
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }

  Future<int> editarProjeto(Map<String, dynamic> data, int projetoId) async {
    try {
      var response = await _client.put('projeto/${projetoId}', data: data);
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }

  Future<int> excluirProjeto(int projetoId) async {
    try {
      var response = await _client.delete('projeto/${projetoId}');
      return response.statusCode;
    }on DioError catch(e) {
      throw(e.response);
    }
  }
}