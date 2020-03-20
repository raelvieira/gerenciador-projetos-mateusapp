import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/cadastro_projeto/cadastro_module.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/editar_projeto/editar_module.dart';
import 'package:gerenciador_projetos_app/app/modules/tarefas/home/home_tarefa_module.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:gerenciador_projetos_app/shared/widgets/aletas.dart';
import 'package:provider/provider.dart';

import 'componentes/projeto_card.dart';
import 'home_bloc.dart';
import 'home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc = HomeModule.to.getBloc<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    _homeBloc.getProjetos();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => CadastroModule())
          );
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), child: Divider(height: 1, color: Colors.black,))),
                Text("G", style: TextStyle(fontSize: 35, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
                Text("Proj", style: TextStyle(fontSize: 35, color: Theme.of(context).accentColor),),
                Expanded(child: Container(margin: const EdgeInsets.symmetric(horizontal: 10), child: Divider(height: 1, color: Colors.black,))),
              ],
            ),
            StreamBuilder<List>(
              stream: _homeBloc.outProjetos,
              builder: (context, snapshot) {
                if(!snapshot.hasData) {
                  return Center(heightFactor: 5, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),);
                }else if(snapshot.data.length == 0) {
                  return Center(
                    heightFactor: 5,
                    child: Column(
                      children: <Widget>[
                        Text("Não há projetos aqui...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("Clique no botão + para adicionar um projeto", style: TextStyle(fontSize: 18,)),
                      ],
                    ),
                  );
                }else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ProjetoCard(
                            titulo: snapshot.data[index].titulo,
                            descricao: snapshot.data[index].descricao,
                            dataPrevisaoEntrega: snapshot.data[index].dataPrevisaoEntrega,
                            status: snapshot.data[index].status,
                            onPressedFinalizar: () async {
                              int statusCode = await _homeBloc.finalizarProjeto(snapshot.data[index].id);
                              if(statusCode == 200 || statusCode == 201){
                                _homeBloc.getProjetos();
                                Alerta.alertaInferiorComBarra(context, "Projeto finalizado com sucesso!", Icons.check, Colors.lightGreen);
                              }
                            },
                            onPressedEditar: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(builder: (context) => Provider<Projeto>.value(value: snapshot.data[index], child: EditarModule(),))
                              );
                            },
                            onPressedVisualizar: () {
                              Navigator.of(context).push(
                                  CupertinoPageRoute(builder: (context) => Provider<Projeto>.value(value: snapshot.data[index], child: HomeTarefaModule(),))
                              );
                            },
                          );
                        }
                      ),
                    ),
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}
