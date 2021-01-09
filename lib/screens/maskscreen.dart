import 'package:calculadora_de_redes/tools/herramientas.dart';
import 'package:flutter/material.dart';

class MascaraScreen extends StatefulWidget {
  @override
  _MascaraScreenState createState() => _MascaraScreenState();
}

class _MascaraScreenState extends State<MascaraScreen> {
  String _dropDownValue;
  double _slideMascaraValue = 1;
  String _subnetMask = "";
  String _subnetWillcard = "";
  String _subnetBinarioMask = "";
  String _subnetBinarioWillcard = "";
  String _slash = "";

  var _txtMascara = TextEditingController();

  Widget selectMascara() {
    return DropdownButton(
      hint: _dropDownValue == null ? Text('Select') : Text(_dropDownValue),
      isExpanded: true,
      items: listaMascaras.map((e) {
        return DropdownMenuItem(value: e.mascara, child: Text(e.mascara));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _dropDownValue = value;
          Mascara tmpMascara = getObjetoMascara(value);
          _slideMascaraValue = double.parse(tmpMascara.abreviatura);
          calculos();
        });
      },
    );
  }

  Widget slideMascara() {
    return Slider(
        value: _slideMascaraValue,
        max: 32,
        min: 1,
        onChanged: (v) {
          setState(() {
            _slideMascaraValue = v;
            calculos();
          });
        });
  }

  Future<void> calculos() async {
    Mascara tmpMascara = diccionarioMascaras[_slideMascaraValue.toInt()];
    tmpMascara.willcardMask();
    _dropDownValue = tmpMascara.mascara;
    _txtMascara.text = tmpMascara.abreviatura;
    _subnetMask = tmpMascara.mascara;
    _subnetWillcard = convertidorBinarioaDecimal(tmpMascara.willcard);
    _slash = "/" + tmpMascara.abreviatura;
    _subnetBinarioMask = tmpMascara.getMascaraBinaria();
    _subnetBinarioWillcard = tmpMascara.willcard;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          margin: EdgeInsets.all(3),
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(flex: 3, child: selectMascara()),
                  ],
                ),
                slideMascara(),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Subnet Mask       $_subnetMask'),
                      Text('Willcard Mask     $_subnetWillcard'),
                      Text('Slash Notation    $_slash'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Subnet Mask     $_subnetBinarioMask'),
                      Text('Wildcard Mask   $_subnetBinarioWillcard'),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
