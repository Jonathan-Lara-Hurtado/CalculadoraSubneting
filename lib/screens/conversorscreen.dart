import 'package:calculadora_de_redes/tools/herramientas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversorScreen extends StatefulWidget {
  @override
  _ConversorScreenState createState() => _ConversorScreenState();
}

class _ConversorScreenState extends State<ConversorScreen> {
  String radioItemDe = 'decimal';
  String radioItemPara = "binario";
  int idDe = 1;
  int idPara = 2;
  var _txtCantidadConvertir = TextEditingController();

  String _error = "";
  bool _modalEstado = false;

  Widget barraDatoIngresado() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('De:'),
          Container(
            color: Get.isDarkMode ? Colors.grey[700] : Colors.blue[50],
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: sistemaNumeracionLista
                  .map(
                    (e) => Container(
                      width: 160.0,
                      child: Row(
                        children: [
                          Radio(
                              value: e.index,
                              groupValue: idDe,
                              onChanged: (val) {
                                setState(() {
                                  radioItemDe = e.name;
                                  idDe = e.index;
                                });
                              }),
                          Text(e.label),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_left),
              Text('Swipe to see more options'),
              Icon(Icons.arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  Widget barraDatoAdar() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('A:'),
          Container(
            color: Get.isDarkMode ? Colors.grey[700] : Colors.blue[50],
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: sistemaNumeracionLista
                  .map((e) => e.name != radioItemDe
                      ? Container(
                          width: 160.0,
                          child: Row(
                            children: [
                              Radio(
                                  value: e.index,
                                  groupValue: idPara,
                                  onChanged: (val) {
                                    setState(() {
                                      radioItemPara = e.name;
                                      idPara = e.index;
                                    });
                                  }),
                              Text(e.label),
                            ],
                          ),
                        )
                      : Container())
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_left),
              Text('Swipe to see more options'),
              Icon(Icons.arrow_right),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> calculos() async {
    if (_txtCantidadConvertir.text.isNotEmpty) {
      if (radioItemDe != radioItemPara) {
        ConversorSistemasNumericos conversorNumerico =
            ConversorSistemasNumericos(
                cantidad: _txtCantidadConvertir.text,
                tipoEntrada: radioItemDe,
                tipoSalida: radioItemPara);

        if (conversorNumerico.esEntradaValido) {
          _txtCantidadConvertir.text = conversorNumerico.resultado();
        } else {
          setState(() {
            _error = "INVALID ENTRY VALUE";
            _modalEstado = true;
          });
        }
      } else {
        setState(() {
          _error = "ERROR";
          _modalEstado = true;
        });
      }
    } else {
      setState(() {
        _error = "ENTER A VALUE";
        _modalEstado = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(children: [
                Flexible(
                  child: TextField(
                    controller: _txtCantidadConvertir,
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        hintText: 'ENTER THE AMOUNT TO CONVERT'),
                  ),
                ),
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                      left: BorderSide(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: FlatButton(
                      onPressed: () {
                        _txtCantidadConvertir.clear();
                      },
                      child: Icon(Icons.delete)),
                ),
              ]),
              barraDatoIngresado(),
              barraDatoAdar(),
              RaisedButton(
                child: Text(
                  'CALCULATE',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _modalEstado = false;
                    FocusScope.of(context).unfocus();
                    calculos();
                    if (_modalEstado) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(_error),
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                  });
                },
                color: Colors.blue[500],
              ),
            ],
          ),
        )
      ],
    );
  }
}
