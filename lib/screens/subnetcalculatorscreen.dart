import 'package:calculadora_de_redes/tools/herramientas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorSubnetScreen extends StatefulWidget {
  @override
  _CalculatorSubnetScreenState createState() => _CalculatorSubnetScreenState();
}

class _CalculatorSubnetScreenState extends State<CalculatorSubnetScreen> {
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
                calculos();
              } else {
                setState(() {
                  validarDatos = false;
                  error = "MASK NOT SUPPORTED";
                });
              }
            }
          },
        )),
      ],
    );
  }

  Future<void> calculos() async {
    if (valorPrimerOcteto.isNotEmpty &&
        valorSegundoOcteto.isNotEmpty &&
        valorTerceroOcteto.isNotEmpty &&
        valorCuartoocteto.isNotEmpty) {
      int _numeroPrimerOcteto = int.parse(valorPrimerOcteto);
      int _numeroSeguntoOcteto = int.parse(valorSegundoOcteto);
      int _numeroTercerOcteto = int.parse(valorTerceroOcteto);
      int _numeroCuartoOcteto = int.parse(valorCuartoocteto);

      if (_numeroPrimerOcteto < 256 &&
          _numeroSeguntoOcteto < 256 &&
          _numeroTercerOcteto < 256 &&
          _numeroCuartoOcteto < 256) {
        setState(() {
          validarDatos = true;
          //Mascara
          Mascara tmpMascara = diccionarioMascaras[_slideMascara.toInt()];
          _mascaraBinario = tmpMascara.getMascaraBinaria();
          _mascaraNoBinario = tmpMascara.mascara;
          _availableHost = tmpMascara.getNumeroHostRetornar();
          //Network
          CalculadoraIpv4 calculadora = CalculadoraIpv4(
              primerOctato: valorPrimerOcteto,
              segundoOcteto: valorSegundoOcteto,
              tercerOcteto: valorTerceroOcteto,
              cuartoOcteto: valorCuartoocteto,
              mascara: _mascaraBinario);
          calculadora.getDireccionBinario();
          _networkBinario = calculadora.stringBinarioNetwork();
          _primerHostBinario = calculadora.stringBinarioFirstNetwork();
          _broadcastBinario = calculadora.stringBinarioBroadcastNetwork();
          _ultimoHostBinario = calculadora.stringBinarioLastNetwork();
          //Conversion a decimal
          _networkNoBinario = convertidorBinarioaDecimal(_networkBinario);
          _primerNoHostBinario = convertidorBinarioaDecimal(_primerHostBinario);
          _ultimoNoHostBinario = convertidorBinarioaDecimal(_ultimoHostBinario);
          _broadcastNoBinario = convertidorBinarioaDecimal(_broadcastBinario);
        });
      } else {
        setState(() {
          validarDatos = false;
          error = "SOME BOXES EXCEED THE LIMIT OF 0 - 255";
        });
      }
    } else {
      setState(() {
        validarDatos = false;
        error = "SOME BOX IS BLANK!";
      });
    }
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
          calculos();
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  void _limpiarOctetos() {
    setState(() {
      validarDatos = false;
      _txtPrimerOcteto.clear();
      _txtSegundoOcteto.clear();
      _txtTerceroOcteto.clear();
      _txtCuartoOcteto.clear();
      valorPrimerOcteto = "";
      valorSegundoOcteto = "";
      valorTerceroOcteto = "";
      valorCuartoocteto = "";
    });
  }

  @override
  void initState() {
    super.initState();
    _txtMascara.text = _slideMascara.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('IPv4 network address'),
                    FlatButton(
                      onPressed: _limpiarOctetos,
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.blue[500],
                        size: 30,
                      ),
                    ),
                  ],
                ),
                barraOctetos(),
                barraMascaraSlider(),
              ],
            ),
          ),
        ),
        Card(
          child: validarDatos
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Network           $_networkNoBinario'),
                          Text('Subnet Mask       $_mascaraNoBinario'),
                          Text('First Host        $_primerNoHostBinario'),
                          Text('Last Host         $_ultimoNoHostBinario'),
                          Text('Broadcast         $_broadcastNoBinario'),
                          Text('Available Hosts   $_availableHost')
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Network          $_networkBinario'),
                          Text('Subnet Mask      $_mascaraBinario'),
                          Text('First Host       $_primerHostBinario'),
                          Text('Last Host        $_ultimoHostBinario'),
                          Text('Broadcast        $_broadcastBinario'),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(padding: EdgeInsets.all(15), child: Text('$error')),
        ),
      ],
    );
  }
}
