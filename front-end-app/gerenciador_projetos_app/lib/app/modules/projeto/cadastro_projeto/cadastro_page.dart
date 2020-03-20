import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/cadastro_projeto/cadastro_bloc.dart';
import 'package:gerenciador_projetos_app/app/modules/projeto/cadastro_projeto/cadastro_module.dart';
import 'package:gerenciador_projetos_app/shared/widgets/text_input.dart';
import 'package:gerenciador_projetos_app/shared/widgets/aletas.dart';
import 'package:gerenciador_projetos_app/shared/widgets/date_picker.dart';
import 'package:gerenciador_projetos_app/shared/widgets/floating_button.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CadastroBloc _cadastroBloc = CadastroModule.to.getBloc<CadastroBloc>();

  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  TextEditingController _controllerPrevisaoEntrega = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingButton(
        stream: _cadastroBloc.outSubmitValido,
        child: Text('Ok'),
        onPressed: _cadastrar,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 60, right: 20, bottom: 80, left: 60,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextInput(
                textoApresentacao: "Digite o título",
                stream: _cadastroBloc.outTitulo,
                onChanged: _cadastroBloc.changeTitulo,
                controller: _controllerTitulo,
              ),
              TextInput(
                stream: _cadastroBloc.outDescricao,
                onChanged: _cadastroBloc.changeDescricao,
                controller: _controllerDescricao,
                textoApresentacao: "Digite a descrição",
                fontSize: 20,
                textoNegrito: false,
                qtdLinhas: 2,
              ),
              CampoDate(
                textoApresentacao: "Selecione a data de entrega",
                stream: _cadastroBloc.outPrevisaoEntrega,
                controller: _controllerPrevisaoEntrega,
                onChanged: (date) {
                  _cadastroBloc.changePrevisaoEntrega(date);
                  _controllerPrevisaoEntrega.clear();
                },
              ),
              Divider(
                height: 10,
                thickness: 2,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Não há tarefas aqui...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text("Primeiro cadastre o projeto", style: TextStyle(fontSize: 17, color: Colors.grey[700], letterSpacing: .2),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _cadastrar() async {
    try {
      int statusCode = await _cadastroBloc.salvarProjeto();
      if(statusCode == 200 || statusCode == 201) {
        _resetCampos();
        Alerta.alertaInferiorComBarra(context, "Projeto criado com sucesso!", Icons.check, Colors.lightGreen);
      }
    }catch (e) {
      _dialogoErro();
    }
  }

  void _resetCampos(){
    _controllerTitulo.clear();
    _controllerDescricao.clear();
  }

  void _dialogoErro() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Não foi possível criar o projeto!"),
          content: Text("Houve um erro inesperado! \nPor favor, verifique se já não há um projeto com esse nome."),
          actions: [
            FlatButton(
              child: Text("Entendi!"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
