import 'package:flutter/material.dart';

class ProjetoCard extends StatelessWidget {

  final String titulo;
  final String descricao;
  final DateTime dataPrevisaoEntrega;
  final String status;

  final Function onPressedVisualizar;
  final Function onPressedEditar;
  final Function onPressedFinalizar;

  const ProjetoCard({
    this.titulo,
    this.descricao,
    this.dataPrevisaoEntrega,
    this.status,
    this.onPressedVisualizar,
    this.onPressedEditar,
    this.onPressedFinalizar
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(this.titulo, style: TextStyle(color: Theme.of(context).primaryColor),),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(this.descricao == null ? "O projeto não possui descrição!" : this.descricao)
                        ),
                        subtitle: Text("Previsão: ${this.dataPrevisaoEntrega.day}/${this.dataPrevisaoEntrega.month}/${this.dataPrevisaoEntrega.year}",),
                        trailing: Text(this.status),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: this.onPressedVisualizar,
                        textColor: Colors.blueAccent,
                        child: Text("Visualizar"),
                      ),
                      FlatButton(
                        onPressed: this.onPressedEditar,
                        textColor: Colors.grey[850],
                        child: Text("Editar"),
                      ),
                      FlatButton(
                        onPressed: this.onPressedFinalizar,
                        textColor: Colors.green,
                        child: Text("Finalizar"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
