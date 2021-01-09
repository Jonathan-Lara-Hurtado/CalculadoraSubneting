import 'package:calculadora_de_redes/tools/herramientas.dart';
import 'package:flutter/material.dart';

class NetworkSize {
  String cantida;
  int mascaraDada;
  Mascara mascaraNueva;
  String primerOctato;
  String segundoOcteto;
  String tercerOcteto;
  String cuartoOcteto;

  NetworkSize(
      {this.cantida,
      this.mascaraDada,
      this.primerOctato,
      this.segundoOcteto,
      this.tercerOcteto,
      this.cuartoOcteto});

  void nuevaMascara() {
    Mascara anterior;
    for (var i in listaMascaras) {
      int host = int.parse(i.getNumeroHostRetornar());
      int tmpCantidad = int.parse(this.cantida);
      if (host > tmpCantidad) {
        anterior = i;
      } else {
        break;
      }
    }
    this.mascaraNueva = anterior;
  }

  Widget salida() {
    this.nuevaMascara();
    CalculadoraIpv4 cal = CalculadoraIpv4(
        primerOctato: this.primerOctato,
        segundoOcteto: this.segundoOcteto,
        tercerOcteto: this.tercerOcteto,
        cuartoOcteto: this.cuartoOcteto,
        mascara: this.mascaraNueva.getMascaraBinaria());

    cal.getDireccionBinario();

    String network = convertidorBinarioaDecimal(cal.stringBinarioNetwork()) +
        "/" +
        this.mascaraNueva.abreviatura;
    String firstHost =
        convertidorBinarioaDecimal(cal.stringBinarioFirstNetwork());
    String broadcast =
        convertidorBinarioaDecimal(cal.stringBinarioBroadcastNetwork());
    String lastHost =
        convertidorBinarioaDecimal(cal.stringBinarioLastNetwork());

    String numHost = this.mascaraNueva.getNumeroHostRetornar();

    double porcentajeDos = int.parse(this.cantida) / int.parse(numHost);

    String porcentaje = (porcentajeDos * 100).round().toString();

    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Network       $network'),
          Text('First Host    $firstHost'),
          Text('Last Host     $lastHost'),
          Text('Broadcast     $broadcast'),
          Text('Requiere Host $cantida Allocate $numHost   ($porcentaje%)')
        ],
      ),
    );
  }
}

class NetworkEntrada extends StatelessWidget {
  Function eliminar;
  Function cambioTexto;
  int numero;

  NetworkEntrada({this.eliminar, this.numero, this.cambioTexto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text('Network $numero size'),
          Flexible(
              child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            onChanged: cambioTexto,
          )),
          ElevatedButton.icon(
              onPressed: eliminar, icon: Icon(Icons.delete), label: Text('')),
        ],
      ),
    );
  }
}
