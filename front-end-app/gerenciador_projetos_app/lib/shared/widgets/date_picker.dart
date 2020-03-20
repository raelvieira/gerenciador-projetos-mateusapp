import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class CampoDate extends StatefulWidget {
  final String textoApresentacao;
  final Stream<DateTime> stream;
  final Function(DateTime) onChanged;
  TextEditingController controller;
  final bool ativado;
  final DateTime valorInicialNoCampo;

  String _dataHora;
  DateTime _minTime;
  var _formatter = DateFormat("dd/MM/yyyy 'às' HH:mm");

  CampoDate({
    this.textoApresentacao,
    this.stream,
    this.onChanged,
    this.controller,
    this.ativado,
    this.valorInicialNoCampo
  }) {
    if(this.valorInicialNoCampo != null){
      onChanged(valorInicialNoCampo);
      _minTime = valorInicialNoCampo;
      _dataHora = _formatter.format(valorInicialNoCampo);
      controller = TextEditingController();
      controller.value = TextEditingValue(text: _dataHora);
    }else {
      _minTime = DateTime.now();
      _dataHora = "Selecione a data/hora";
    }
  }

  @override
  _CampoDateState createState() => _CampoDateState();
}

class _CampoDateState extends State<CampoDate> {
  void _exibirSeletor() {
    DatePicker.showDateTimePicker(
        context,
        theme: DatePickerTheme(containerHeight: 210.0,),
        showTitleActions: true,
        minTime: widget._minTime,
        onConfirm: (dataHora) {
          setState(() {
            widget.onChanged(dataHora);
            widget._dataHora = widget._formatter.format(dataHora);
            widget.controller.value = TextEditingValue(text: widget._dataHora);
          });
        },
        currentTime: DateTime.now(),
        locale: LocaleType.pt
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: widget.stream,
      builder: (context, snapshot){
        return TextFormField(
          enabled: widget.ativado,
          controller: widget.controller,
          keyboardType: TextInputType.datetime,
          showCursor: false,
          readOnly: true,
          onTap: _exibirSeletor,
          decoration: InputDecoration(
            hasFloatingPlaceholder: false,
            hintText: widget.textoApresentacao,
            hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Color.fromARGB(90, 0, 0, 0)),
            border: InputBorder.none,
            errorText: snapshot.hasError ? snapshot.error : null,
          )
        );
      },
    );
  }
}
