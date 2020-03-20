import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/app/app_module.dart';

import '../../../../repositories/projeto_repository.dart';
import 'cadastro_bloc.dart';
import 'cadastro_page.dart';


class CadastroModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => CadastroBloc(AppModule.to.getDependency<ProjetoRepository>())),
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => CadastroPage();

  static Inject get to => Inject<CadastroModule>.of();
}