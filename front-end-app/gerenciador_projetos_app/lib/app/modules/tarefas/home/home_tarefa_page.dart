import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:gerenciador_projetos_app/models/tarefa_projeto.dart';
import 'package:gerenciador_projetos_app/shared/widgets/aletas.dart';
import 'package:gerenciador_projetos_app/shared/widgets/text_input.dart';
import 'package:provider/provider.dart';

import 'components/tarefa_card.dart';
import 'home_tarefa_bloc.dart';
import 'home_tarefa_module.dart';

class HomeTarefaPage extends StatefulWidget {
  @override
  _HomeTarefaPageState createState() => _HomeTarefaPageState();
}

class _HomeTarefaPageState extends State<HomeTarefaPage> {
  Projeto _projeto;
  HomeTarefaBloc _homeTarefaBloc = HomeTarefaModule.to.getBloc<HomeTarefaBloc>();

  @override
  Widget build(BuildContext context) {
    _projeto = Provider.of<Projeto>(context);
    _homeTarefaBloc.getTarefas(_projeto.id);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear, size: 35, color: Colors.black,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _adicionarTarefa,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60, right: 20, bottom: 80, left: 60,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _projeto.titulo,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _projeto.descricao == null ? 'O projeto não possui descrição!' : _projeto.descricao,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                "Previsão de término: ${_projeto.dataPrevisaoEntrega.day}/${_projeto.dataPrevisaoEntrega.month}/${_projeto.dataPrevisaoEntrega.year}",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Status: ${_projeto.status}",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                  )
                ),
              ),
              Divider(
                height: 10,
                thickness: 2,
              ),
              StreamBuilder<List<TarefaProjeto>>(
                stream: _homeTarefaBloc.outTarefas,
                builder: (context, snapshot) {
                  if(!snapshot.hasData) {
                    return Center(heightFactor: 5, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),);
                  }else if(snapshot.data.length == 0){
                    return Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Não há tarefas aqui...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text("Aperte no + para adicionar uma tarefa", style: TextStyle(fontSize: 17, color: Colors.grey[700], letterSpacing: .2),)
                        ],
                      ),
                    );
                  }else {
                    return SingleChildScrollView(
                      child: Column(
                        children: snapshot.data.map( (item) => TarefaCard(
                          titulo: item.titulo,
                          corCard: item.status.toUpperCase() == "ABERTA" ? Colors.red : Colors.green,
                          funcaoTitulo: () async {
                            int statusCode = await _homeTarefaBloc.finalizarTarefa(item.id);
                            if(statusCode == 200 || statusCode == 201){
                              _homeTarefaBloc.getTarefas(_projeto.id);
                            }
                          },
                        ) ).toList(),
                      ),
                    );
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  void _adicionarTarefa() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Tarefa'),
          content: TextInput(
            textoApresentacao: 'Digite um nome',
            stream: _homeTarefaBloc.outTitulo,
            onChanged: _homeTarefaBloc.changeTitulo,
            fontSize: 20,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Confirmar"),
              onPressed: () {
                _cadastrar();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
  }

  void _cadastrar() async {
    int statusCode = await _homeTarefaBloc.salvarTarefa(_projeto.id);
    if(statusCode == 200 || statusCode == 201) {
      Alerta.alertaInferiorComBarra(context, "Tarefa criada com sucesso!", Icons.check, Colors.lightGreen);
      _homeTarefaBloc.getTarefas(_projeto.id);
    }
  }
}
