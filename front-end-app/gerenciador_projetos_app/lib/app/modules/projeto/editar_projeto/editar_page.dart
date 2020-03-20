import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/shared/widgets/text_input.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/editar_projeto/editar_bloc.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/editar_projeto/editar_module.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/home/home_bloc.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/home/home_module.dart';
import 'package:gerenciador_projetos_app/models/projeto.dart';
import 'package:gerenciador_projetos_app/shared/widgets/aletas.dart';
import 'package:gerenciador_projetos_app/shared/widgets/date_picker.dart';
import 'package:provider/provider.dart';

class EditarPage extends StatefulWidget {
  @override
  _EditarPageState createState() => _EditarPageState();
}

class _EditarPageState extends State<EditarPage> {
  EditarBloc _editarBloc = EditarModule.to.getBloc<EditarBloc>();
  HomeBloc _homeBloc = HomeModule.to.getBloc<HomeBloc>();
  Projeto _projetoEdicao;

  @override
  Widget build(BuildContext context) {
    _projetoEdicao = Provider.of<Projeto>(context);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear, size: 35, color: Colors.black,),
            onPressed: () {
              _homeBloc.getProjetos();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 60, right: 20, bottom: 80, left: 20,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Editar Informações do",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[500]
                    ),
                  ),
                  Text(
                    "Projeto",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 2,
                  ),
                  TextInput(
                    valorInicialNoCampo: _projetoEdicao.titulo,
                    stream: _editarBloc.outTitulo,
                    onChanged: _editarBloc.changeTitulo,
                  ),
                  TextInput(
                    valorInicialNoCampo: _projetoEdicao.descricao != null ? _projetoEdicao.descricao : null,
                    textoApresentacao: _projetoEdicao.descricao != null ? _projetoEdicao.descricao : "Digite a descrição",
                    stream: _editarBloc.outDescricao,
                    onChanged: _editarBloc.changeDescricao,
                    fontSize: 20,
                    textoNegrito: false,
                    qtdLinhas: 2,
                  ),
                  CampoDate(
                    valorInicialNoCampo: _projetoEdicao.dataPrevisaoEntrega,
                    stream: _editarBloc.outPrevisaoEntrega,
                    onChanged: _editarBloc.changePrevisaoEntrega,
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20, left: 20),
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  child: FlatButton(
                    child: Center(child: Text("Confirmar", style: TextStyle(fontSize: 17, color: Colors.white),)),
                    onPressed: _editar,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 12,
                  child: FlatButton(
                    child: Center(child: Text("Excluir", style: TextStyle(fontSize: 17, color: Colors.white),)),
                    onPressed: _excluir,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editar() async {
    int statusCode = await _editarBloc.editarProjeto(_projetoEdicao.id);
    if(statusCode == 200) {
      Alerta.alertaInferiorComBarra(context, "Alterações realizadas com sucesso!", Icons.check, Colors.lightGreen);
      _homeBloc.getProjetos();
    }else if (statusCode == -1) {
      Alerta.alertaInferiorComBarra(context, "Por favor, digite uma data futura ou presente", Icons.error, Colors.red);
    }
  }

  void _excluir() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção!"),
          content: Text("Você tem certeza que deseja excluir este projeto?"),
          actions: [
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirmar"),
              onPressed:  () {
                Navigator.of(context).pop();
                _excluirProjeto();
              },
            ),
          ],
        );
      },
    );
  }

  Future _excluirProjeto() async {
    int statusCode = await _editarBloc.excluirProjeto(_projetoEdicao.id);
    if(statusCode == 200) {
      _homeBloc.getProjetos();
      Navigator.of(context).pop();
    }
  }
}
