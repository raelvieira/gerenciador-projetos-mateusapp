import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/app/app_module.dart';

import '../../../../repositories/projeto_repository.dart';
import 'editar_bloc.dart';
import 'editar_page.dart';


class EditarModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
    Bloc((i) => EditarBloc(AppModule.to.getDependency<ProjetoRepository>())),
  ];

  @override
  List<Dependency> get dependencies => [

  ];

  @override
  Widget get view => EditarPage();

  static Inject get to => Inject<EditarModule>.of();
}