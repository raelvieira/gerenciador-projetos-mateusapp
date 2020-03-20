import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/repositories/tarefa_repository.dart';

import '../../../app_module.dart';
import 'home_tarefa_bloc.dart';
import 'home_tarefa_page.dart';

class HomeTarefaModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => HomeTarefaBloc(AppModule.to.getDependency<TarefaRepository>())),
  ];

  @override
  List<Dependency> get dependencies => [
  ];

  @override
  Widget get view => HomeTarefaPage();

  static Inject get to => Inject<HomeTarefaModule>.of();
}