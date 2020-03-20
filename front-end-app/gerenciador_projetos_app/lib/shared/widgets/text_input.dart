import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final Stream<String> stream;
  final Function(String) onChanged;
  final TextEditingController controller;
  final double fontSize;
  final String textoApresentacao;
  final bool textoNegrito;
  final int qtdLinhas;
  final String valorInicialNoCampo;

  TextInput({
    this.stream,
    this.onChanged,
    this.fontSize = 35,
    this.textoApresentacao,
    this.textoNegrito = true,
    this.qtdLinhas = 1,
    this.controller,
    this.valorInicialNoCampo
  }) {
    if(valorInicialNoCampo != null) {
     onChanged(valorInicialNoCampo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: this.stream,
      builder: (context, snapshot){
        return TextFormField(
          initialValue: this.valorInicialNoCampo != null ? this.valorInicialNoCampo : null,
          maxLines: this.qtdLinhas,
          minLines: 1,
          onChanged: this.onChanged,
          textCapitalization: TextCapitalization.words,
          style: TextStyle(fontSize: this.fontSize, fontWeight: this.textoNegrito ? FontWeight.bold : FontWeight.normal,),
          decoration: InputDecoration(
              hintText: this.textoApresentacao,
              hintStyle: TextStyle(fontSize: this.fontSize, fontWeight: this.textoNegrito ? FontWeight.bold : FontWeight.normal, color: Color.fromARGB(90, 0, 0, 0)),
              border: InputBorder.none,
              errorText: snapshot.hasError ? snapshot.error : null
          ),
          controller: controller,
        );
      },
    );
  }
}