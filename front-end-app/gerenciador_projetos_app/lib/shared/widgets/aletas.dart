import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Alerta {
  static final MENSAGEM_PADRAO = 'Houve um erro inesperado. Por favor, tente novamente mais tarde!';

  static Widget alertaInferiorComBarra(BuildContext context, String mensagem, IconData icone, Color corBarrinhaIcone){
    return Flushbar(
      message: mensagem,
      icon: Icon(
        icone,
        size: 28.0,
        color: corBarrinhaIcone,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: corBarrinhaIcone,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  static Widget alertaErroPadrao(BuildContext context){
    return Flushbar(
      message: MENSAGEM_PADRAO,
      icon: Icon(
        Icons.warning,
        size: 28.0,
        color:  Colors.redAccent,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor:  Colors.redAccent,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }
}