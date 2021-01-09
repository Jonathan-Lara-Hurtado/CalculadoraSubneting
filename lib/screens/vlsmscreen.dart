import 'package:calculadora_de_redes/screens/networkwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

class VlsmScreen extends StatefulWidget {
  @override
  _VlsmScreenState createState() => _VlsmScreenState();
}

class _VlsmScreenState extends State<VlsmScreen> {
  //focus nodo
  final FocusNode _primerOctetoNodo = FocusNode();
  final FocusNode _segundoOctetoNodo = FocusNode();
  final FocusNode _tercerOctetoNodo = FocusNode();
  final FocusNode _cuartoOctetoNodo = FocusNode();
  final FocusNode _mascaraOctetoNodo = FocusNode();

  //controladores
  var _txtPrimerOcteto = TextEditingController();
  var _txtSegundoOcteto = TextEditingController();
  var _txtTerceroOcteto = TextEditingController();
  var _txtCuartoOcteto = TextEditingController();
  var _txtMascara = TextEditingController();

  //slideValor
  double _slideMascara = 1;

  bool validarDatos = false;

  //guardar valores de los octetos
  String valorPrimerOcteto = "";
  String valorSegundoOcteto = "";
  String valorTerceroOcteto = "";
  String valorCuartoocteto = "";

  String error = "";

  //apartado no binario
  String _networkNoBinario;
  String _mascaraNoBinario;
  String _primerNoHostBinario;
  String _ultimoNoHostBinario;
  String _broadcastNoBinario;
  String _availableHost;

  //Apartado binario
  String _networkBinario;
  String _mascaraBinario;
  String _primerHostBinario;
  String _ultimoHostBinario;
  String _broadcastBinario;

  bool activaProceso = false;

  barraOctetos() {
    return Row(
      children: [
        Flexible(
            child: TextField(
          textAlign: TextAlign.center,
          controller: _txtPrimerOcteto,
          focusNode: _primerOctetoNodo,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: '192'),
          onChanged: (value) {
            setState(() {
              if (value.length < 4) {
                valorPrimerOcteto = value;
              } else {
                _txtPrimerOcteto.text = valorPrimerOcteto;
              }
            });

            if (value.length > 2) {
              FocusScope.of(context).requestFocus(_segundoOctetoNodo);
            }
          },
        )),
        Text('.',
            style: TextStyle(
              fontSize: 50,
            )),
        Flexible(
            child: TextField(
          textAlign: TextAlign.center,
          controller: _txtSegundoOcteto,
          focusNode: _segundoOctetoNodo,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: '168'),
          onChanged: (value) {
            print(value);
            setState(() {
              if (value.length < 4) {
                valorSegundoOcteto = value;
              } else {
                _txtSegundoOcteto.text = valorPrimerOcteto;
              }
            });
            if (value.length > 2) {
              FocusScope.of(context).requestFocus(_tercerOctetoNodo);
            }
          },
        )),
        Text('.',
            style: TextStyle(
              fontSize: 50,
            )),
        Flexible(
            child: TextField(
          textAlign: TextAlign.center,
          controller: _txtTerceroOcteto,
          focusNode: _tercerOctetoNodo,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: '1'),
          onChanged: (value) {
            setState(() {
              if (value.length < 4) {
                valorTerceroOcteto = value;
              } else {
                _txtTerceroOcteto.text = valorTerceroOcteto;
              }
            });
            if (value.length > 2) {
              FocusScope.of(context).requestFocus(_cuartoOctetoNodo);
            }
          },
        )),
        Text('.',
            style: TextStyle(
              fontSize: 50,
            )),
        Flexible(
            child: TextField(
          controller: _txtCuartoOcteto,
          textAlign: TextAlign.center,
          focusNode: _cuartoOctetoNodo,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(hintText: '1'),
          onChanged: (value) {
            setState(() {
              if (value.length < 4) {
                valorCuartoocteto = value;
              } else {
                _txtCuartoOcteto.text = valorCuartoocteto;
              }
            });
            if (value.length > 2) {
              FocusScope.of(context).requestFocus(_mascaraOctetoNodo);
            }
          },
        )),
        Text('/',
            style: TextStyle(
                fontSize: 50, letterSpacing: 50, fontWeight: FontWeight.w100)),
        Flexible(
            child: TextField(
          controller: _txtMascara,
          focusNode: _mascaraOctetoNodo,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            if (value.length > 0) {
              if (double.parse(value) < 33 && double.parse(value) > 0) {
                setState(() {
                  _slideMascara = double.parse(value);
                });
              } else {
                setState(() {
                  validarDatos = false;
                  error = "Mascara no soportada";
                });
              }
            }
          },
        )),
      ],
    );
  }

  Container barraMascaraSlider() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
      child: Slider(
        min: 1,
        max: 32,
        value: _slideMascara,
        onChanged: (value) {
          setState(() {
            _slideMascara = value;
            _txtMascara.text = (value.toInt()).toString();
          });
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
/*
  Widget labelNetwork(delete) {
    Function delete;
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text('Network 1 size'),
          Flexible(
              child: TextField(
            keyboardType: TextInputType.number,
          )),
          ElevatedButton.icon(
              onPressed: () {}, icon: Icon(Icons.delete), label: Text('')),
        ],
      ),
    );
  }
  */

  bool casillaVaciaNetwork() {
    bool resultado = false;
    for (var i in this.pruebaLista) {
      if (i.cantida == null) {
        resultado = true;
      }
    }
    return resultado;
  }

  List<NetworkSize> pruebaLista = [];
  int i = 0;

  void ordenarNetworkLista() {
    int t = pruebaLista.length;
    NetworkSize tmp;
    for (int i = 1; i < t; i++) {
      for (int j = t - 1; j >= i; j--) {
        if (int.parse(pruebaLista[j].cantida) >
            int.parse(pruebaLista[j - 1].cantida)) {
          tmp = pruebaLista[j];
          pruebaLista[j] = pruebaLista[j - 1];
          pruebaLista[j - 1] = tmp;
        }
      }
    }
  }

  void darSegmento() {
    int t = pruebaLista.length;
    bool copia = true;
    for (int i = 0; i < t; i++) {
      if (copia) {
//        pruebaLista[i].copia = true;
      } else {
        copia = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('IPv4 network address'),
                    FlatButton(
                      onPressed: () {
                        ordenarNetworkLista();
                        darSegmento();
                      },
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.blue[500],
                        size: 30,
                      ),
                    ),
                  ],
                ),
                barraOctetos(),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      activaProceso = false;
                      pruebaLista.removeRange(0, pruebaLista.length);
                      pruebaLista.add(
                        NetworkSize(
                          primerOctato: _txtPrimerOcteto.text,
                          segundoOcteto: _txtSegundoOcteto.text,
                          tercerOcteto: _txtTerceroOcteto.text,
                          cuartoOcteto: _txtCuartoOcteto.text,
                          mascaraDada: int.parse(_txtMascara.text),
                        ),
                      );
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          setState(() {
                            i = 0;
                          });
                          return AlertDialog(
                            title: Text("Add Network"),
                            content: Container(
                              height: 300.0,
                              width: 300.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    //                                  color: Colors.blue,
                                    child: ListView(
                                      children: pruebaLista.map((e) {
                                        setState(() {
                                          i++;
                                        });
                                        return NetworkEntrada(
                                          numero: i,
                                          eliminar: () {
                                            setState(() {
                                              pruebaLista.remove(e);
                                            });
                                          },
                                          cambioTexto: (value) {
                                            setState(() {
                                              e.cantida = value;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          i = 0;
                                          pruebaLista.add(
                                            NetworkSize(
                                              primerOctato:
                                                  _txtPrimerOcteto.text,
                                              segundoOcteto:
                                                  _txtSegundoOcteto.text,
                                              tercerOcteto:
                                                  _txtTerceroOcteto.text,
                                              cuartoOcteto:
                                                  _txtCuartoOcteto.text,
                                              mascaraDada:
                                                  int.parse(_txtMascara.text),
                                            ),
                                          );
                                        });
                                      },
                                      child: Text('add'))
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    if (pruebaLista.length > 0) {
                                      if (!casillaVaciaNetwork()) {
                                        setState(() {
                                          activaProceso = true;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Error casilla en blanco'),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {},
                                            ),
                                          ),
                                        );
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('sin datos'),
                                          action: SnackBarAction(
                                            label: 'OK',
                                            onPressed: () {},
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Aceptar'))
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: Text(
                    'Configure networks',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activaProceso
                    ? pruebaLista.map((e) {
                        return e.salida();
                      }).toList()
                    : []),
          ),
        )
      ],
    );
  }
}
