import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/repositories/tarefa_repository.dart';
import 'package:gerenciador_projetos_app/shared/custom_dio/custom_dio.dart';

import 'app_bloc.dart';
import 'app_page.dart';
import '../repositories/projeto_repository.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => AppBloc()),
  ];

  @override
  List<Dependency> get dependencies => [
    Dependency((i) => CustomDio()),
    Dependency((i) => ProjetoRepository(AppModule.to.getDependency<CustomDio>())),
    Dependency((i) => TarefaRepository(AppModule.to.getDependency<CustomDio>()))
  ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}