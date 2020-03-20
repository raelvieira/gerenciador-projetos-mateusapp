import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TarefaCard extends StatelessWidget {
  final String titulo;
  final Function funcaoTitulo;
  final Function funcaoEdicao;
  final Color corCard;

  const TarefaCard({
    this.titulo,
    this.funcaoTitulo,
    this.funcaoEdicao,
    this.corCard = Colors.red
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: corCard,
        child: Row(
          children: <Widget>[
           Expanded(
             child: ListTile(
               title: FlatButton(
                 child: Text(this.titulo, style: TextStyle(color: Colors.white, fontSize: 15),),
                 onPressed: funcaoTitulo,
               ),
               trailing:  IconButton(
                 icon: Icon(Icons.edit, color: Colors.white,),
                 onPressed: funcaoEdicao,
               ),
             ),
           )
          ],
        ),
      )
    );
  }
}
