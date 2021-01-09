import 'dart:math';

String convertidorBinarioaDecimal(String valor) {
  int exponente = 7;
  int valorOcteto = 0;
  var octetos = valor.split('.');
  int posicionOcteto = 0;

  String resultado = "";
  for (var i in octetos) {
    valorOcteto = 0;
    exponente = 7;
    for (int e = 0; e <= i.length - 1; e++) {
      if (int.parse(i[e]) == 1) {
        valorOcteto += pow(2, exponente);
      }
      exponente--;
    }
    resultado += valorOcteto.toString() + (posicionOcteto < 3 ? '.' : '');
    posicionOcteto++;
  }
  return resultado;
}

String stringBinarioCompleto(String valor) {
  int numero = int.parse(valor);
  String binario = numero.toRadixString(2);
  String resultado = "";

  if (binario.length < 8) {
    int contador = 8 - binario.length;
    int i = 1;
    while (i <= contador) {
      resultado += "0";
      i++;
    }
  }
  resultado = resultado + binario;
  return resultado;
}

class CalculadoraIpv4 {
  String primerOctato;
  String segundoOcteto;
  String tercerOcteto;
  String cuartoOcteto;
  String mascara;
  String direccionBinario;
  String networkBinario;
  String willcard;
  String broadcastBinario;

  CalculadoraIpv4(
      {this.primerOctato,
      this.segundoOcteto,
      this.tercerOcteto,
      this.cuartoOcteto,
      this.mascara});

  void getDireccionBinario() {
    this.direccionBinario = stringBinarioCompleto(this.primerOctato) +
        "." +
        stringBinarioCompleto(this.segundoOcteto) +
        "." +
        stringBinarioCompleto(this.tercerOcteto) +
        "." +
        stringBinarioCompleto(this.cuartoOcteto);
  }

  String stringBinarioNetwork() {
    String resultado = "";

    for (int i = 0; i <= this.direccionBinario.length - 1; i++) {
      if (this.direccionBinario[i] == this.mascara[i]) {
        resultado += this.direccionBinario[i];
      } else {
        resultado += "0";
      }
    }
    this.networkBinario = resultado;
    return resultado;
  }

  String stringBinarioFirstNetwork() {
    var octetos = this.networkBinario.split('.');
    var ultimoOcteto = "";
    for (int i = 0; i <= 6; i++) {
      ultimoOcteto += octetos[3][i];
    }
    ultimoOcteto += "1";

    return octetos[0] +
        "." +
        octetos[1] +
        "." +
        octetos[2] +
        "." +
        ultimoOcteto;
  }

  String stringBinarioLastNetwork() {
    var octetos = this.broadcastBinario.split('.');
    var ultimoOcteto = "";
    for (int i = 0; i <= 6; i++) {
      ultimoOcteto += octetos[3][i];
    }
    ultimoOcteto += "0";
    return octetos[0] +
        "." +
        octetos[1] +
        "." +
        octetos[2] +
        "." +
        ultimoOcteto;
  }

  void willcardMask() {
    String acomulador = "";
    for (int i = 0; i <= this.mascara.length - 1; i++) {
      switch (this.mascara[i]) {
        case '1':
          acomulador += "0";
          break;

        case '0':
          acomulador += "1";
          break;

        default:
          acomulador += ".";
      }
    }
    this.willcard = acomulador;
  }

  String stringBinarioBroadcastNetwork() {
    willcardMask();
    String resultado = "";
    for (int i = 0; i <= this.networkBinario.length - 1; i++) {
      if (this.willcard[i] == '.' && this.networkBinario[i] == '.') {
        resultado += '.';
      } else {
        if (this.willcard[i] == '0' && this.networkBinario[i] == '0') {
          resultado += '0';
        } else {
          resultado += '1';
        }
      }
    }
    this.broadcastBinario = resultado;
    return resultado;
  }
}

class Mascara {
  String abreviatura;
  String mascara;
  String clase;
  String numHost;
  String macaraBinario;
  String willcard;

  Mascara({this.abreviatura, this.mascara, this.clase, this.numHost});

  void getNumeroHost() {
    int potencia = 32 - int.parse(this.abreviatura);
    this.numHost = pow(2, potencia).toString();
  }

  void willcardMask() {
    String acomulador = "";
    String mascaraBinario = this.getMascaraBinaria();
    for (int i = 0; i <= mascaraBinario.length - 1; i++) {
      switch (mascaraBinario[i]) {
        case '1':
          acomulador += "0";
          break;

        case '0':
          acomulador += "1";
          break;

        default:
          acomulador += ".";
      }
    }
    this.willcard = acomulador;
  }

  String getNumeroHostRetornar() {
    int potencia = 32 - int.parse(this.abreviatura);
    return pow(2, potencia).toString();
  }

  String getMascaraBinaria() {
    String tmp = this.mascara;
    String resultado = "";
    String octeto = "";
    for (int i = 0; i <= tmp.length - 1; i++) {
      if (tmp[i] == ".") {
        resultado += stringBinarioCompleto(octeto) + ".";
        octeto = "";
      } else {
        octeto += tmp[i];
      }
    }
    return (resultado + stringBinarioCompleto(octeto));
  }
}

List<Mascara> listaMascaras = [
  Mascara(abreviatura: '1', mascara: '128.0.0.0', clase: 'A'),
  Mascara(abreviatura: '2', mascara: '192.0.0.0', clase: 'A'),
  Mascara(abreviatura: '3', mascara: '224.0.0.0', clase: 'A'),
  Mascara(abreviatura: '4', mascara: '240.0.0.0', clase: 'A'),
  Mascara(abreviatura: '5', mascara: '248.0.0.0', clase: 'A'),
  Mascara(abreviatura: '6', mascara: '252.0.0.0', clase: 'A'),
  Mascara(abreviatura: '7', mascara: '254.0.0.0', clase: 'A'),
  Mascara(abreviatura: '8', mascara: '255.0.0.0', clase: 'A'),
  Mascara(abreviatura: '9', mascara: '255.128.0.0', clase: 'B'),
  Mascara(abreviatura: '10', mascara: '255.192.0.0', clase: 'B'),
  Mascara(abreviatura: '11', mascara: '255.224.0.0', clase: 'B'),
  Mascara(abreviatura: '12', mascara: '255.240.0.0', clase: 'B'),
  Mascara(abreviatura: '13', mascara: '255.248.0.0', clase: 'B'),
  Mascara(abreviatura: '14', mascara: '255.252.0.0', clase: 'B'),
  Mascara(abreviatura: '15', mascara: '255.254.0.0', clase: 'B'),
  Mascara(abreviatura: '16', mascara: '255.255.0.0', clase: 'B'),
  Mascara(abreviatura: '17', mascara: '255.255.128.0', clase: 'C'),
  Mascara(abreviatura: '18', mascara: '255.255.192.0', clase: 'C'),
  Mascara(abreviatura: '19', mascara: '255.255.224.0', clase: 'C'),
  Mascara(abreviatura: '20', mascara: '255.255.240.0', clase: 'C'),
  Mascara(abreviatura: '21', mascara: '255.255.248.0', clase: 'C'),
  Mascara(abreviatura: '22', mascara: '255.255.252.0', clase: 'C'),
  Mascara(abreviatura: '23', mascara: '255.255.254.0', clase: 'C'),
  Mascara(abreviatura: '24', mascara: '255.255.255.0', clase: 'C'),
  Mascara(abreviatura: '25', mascara: '255.255.255.128', clase: 'Multicast'),
  Mascara(abreviatura: '26', mascara: '255.255.255.192', clase: 'Multicast'),
  Mascara(abreviatura: '27', mascara: '255.255.255.224', clase: 'Multicast'),
  Mascara(abreviatura: '28', mascara: '255.255.255.240', clase: 'Multicast'),
  Mascara(abreviatura: '29', mascara: '255.255.255.248', clase: 'Multicast'),
  Mascara(abreviatura: '30', mascara: '255.255.255.252', clase: 'Multicast'),
  Mascara(abreviatura: '31', mascara: '255.255.255.254', clase: 'Multicast'),
  Mascara(abreviatura: '32', mascara: '255.255.255.255', clase: 'Multicast'),
];

Map<int, Mascara> diccionarioMascaras = {
  1: Mascara(abreviatura: '1', mascara: '128.0.0.0', clase: 'A'),
  2: Mascara(abreviatura: '2', mascara: '192.0.0.0', clase: 'A'),
  3: Mascara(abreviatura: '3', mascara: '224.0.0.0', clase: 'A'),
  4: Mascara(abreviatura: '4', mascara: '240.0.0.0', clase: 'A'),
  5: Mascara(abreviatura: '5', mascara: '248.0.0.0', clase: 'A'),
  6: Mascara(abreviatura: '6', mascara: '252.0.0.0', clase: 'A'),
  7: Mascara(abreviatura: '7', mascara: '254.0.0.0', clase: 'A'),
  8: Mascara(abreviatura: '8', mascara: '255.0.0.0', clase: 'A'),
  9: Mascara(abreviatura: '9', mascara: '255.128.0.0', clase: 'B'),
  10: Mascara(abreviatura: '10', mascara: '255.192.0.0', clase: 'B'),
  11: Mascara(abreviatura: '11', mascara: '255.224.0.0', clase: 'B'),
  12: Mascara(abreviatura: '12', mascara: '255.240.0.0', clase: 'B'),
  13: Mascara(abreviatura: '13', mascara: '255.248.0.0', clase: 'B'),
  14: Mascara(abreviatura: '14', mascara: '255.252.0.0', clase: 'B'),
  15: Mascara(abreviatura: '15', mascara: '255.254.0.0', clase: 'B'),
  16: Mascara(abreviatura: '16', mascara: '255.255.0.0', clase: 'B'),
  17: Mascara(abreviatura: '17', mascara: '255.255.128.0', clase: 'C'),
  18: Mascara(abreviatura: '18', mascara: '255.255.192.0', clase: 'C'),
  19: Mascara(abreviatura: '19', mascara: '255.255.224.0', clase: 'C'),
  20: Mascara(abreviatura: '20', mascara: '255.255.240.0', clase: 'C'),
  21: Mascara(abreviatura: '21', mascara: '255.255.248.0', clase: 'C'),
  22: Mascara(abreviatura: '22', mascara: '255.255.252.0', clase: 'C'),
  23: Mascara(abreviatura: '23', mascara: '255.255.254.0', clase: 'C'),
  24: Mascara(abreviatura: '24', mascara: '255.255.255.0', clase: 'C'),
  25: Mascara(
      abreviatura: '25', mascara: '255.255.255.128', clase: 'Multicast'),
  26: Mascara(
      abreviatura: '26', mascara: '255.255.255.192', clase: 'Multicast'),
  27: Mascara(
      abreviatura: '27', mascara: '255.255.255.224', clase: 'Multicast'),
  28: Mascara(
      abreviatura: '28', mascara: '255.255.255.240', clase: 'Multicast'),
  29: Mascara(
      abreviatura: '29', mascara: '255.255.255.248', clase: 'Multicast'),
  30: Mascara(
      abreviatura: '30', mascara: '255.255.255.252', clase: 'Multicast'),
  31: Mascara(
      abreviatura: '31', mascara: '255.255.255.254', clase: 'Multicast'),
  32: Mascara(
      abreviatura: '32', mascara: '255.255.255.255', clase: 'Multicast'),
};

Mascara getObjetoMascara(String mascara) {
  Mascara tmpMascara;
  for (var i in listaMascaras) {
    if (i.mascara == mascara) {
      tmpMascara = i;
    }
  }
  return tmpMascara;
}

class SistemasDeNumeracion {
  String name;
  int index;
  String titulo;
  String label;
  SistemasDeNumeracion({this.name, this.index, this.label});
}

List<SistemasDeNumeracion> sistemaNumeracionLista = [
  SistemasDeNumeracion(index: 1, name: "decimal", label: "Decimal"),
  SistemasDeNumeracion(index: 2, name: "binario", label: "Binary"),
  SistemasDeNumeracion(index: 3, name: "hexadecimal", label: "Hexadecimal"),
  SistemasDeNumeracion(index: 4, name: "octal", label: "Octal"),
];

class ConversorSistemasNumericos {
  String cantidad;
  String tipoEntrada;
  String tipoSalida;
  ConversorSistemasNumericos(
      {this.cantidad, this.tipoEntrada, this.tipoSalida});

  Map dicDecimal = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
  };

  Map dicOctal = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
  };

  Map dicHexadecimal = {
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    'a': '10',
    'A': '10',
    'b': '11',
    'B': '11',
    'c': '12',
    'C': '12',
    'd': '13',
    'D': '13',
    'e': '14',
    'E': '14',
    'f': '15',
    'F': '15',
  };

  String binarioToDecimal() {
    var exponente = cantidad.length - 1;
    int acomulador = 0;
    for (int i = 0; i < this.cantidad.length; i++) {
      if (this.cantidad[i] != '0') {
        acomulador += pow(2, exponente);
        exponente--;
      } else {
        exponente--;
      }
    }
    return acomulador.toString();
  }

  String octalToDecimal() {
    var exponente = cantidad.length - 1;
    int acomulador = 0;

    for (int i = 0; i < this.cantidad.length; i++) {
      acomulador += int.parse(this.cantidad[i]) * pow(8, exponente);
      exponente--;
    }
    return acomulador.toString();
  }

  String hexaToDecimal() {
    var exponente = cantidad.length - 1;
    int acomulador = 0;
    for (int i = 0; i < this.cantidad.length; i++) {
      acomulador += int.parse(dicHexadecimal[this.cantidad[i].toUpperCase()]) *
          pow(16, exponente);
      exponente--;
    }
    return acomulador.toString();
  }

  bool get esEntradaValido {
    bool resultado = true;
    String numeroFallido = "";
    switch (this.tipoEntrada) {
      case 'decimal':
        for (int i = 0; i < this.cantidad.length; i++) {
          numeroFallido = dicDecimal[this.cantidad[i]];
          if (numeroFallido == null) {
            resultado = false;
            break;
          }
        }
        break;
      case 'binario':
        for (int i = 0; i < this.cantidad.length; i++) {
          if (this.cantidad[i] != '0' && this.cantidad[i] != '1') {
            resultado = false;
            break;
          }
        }
        break;
      case 'hexadecimal':
        for (int i = 0; i < this.cantidad.length; i++) {
          numeroFallido = dicHexadecimal[this.cantidad[i]];
          if (numeroFallido == null) {
            resultado = false;
            break;
          }
        }
        break;
      case 'octal':
        for (int i = 0; i < this.cantidad.length; i++) {
          numeroFallido = dicOctal[this.cantidad[i]];
          if (numeroFallido == null) {
            resultado = false;
            break;
          }
        }
        break;
      default:
    }
    return resultado;
  }

  String resultado() {
    String resultado = '';
    if (this.tipoEntrada == 'decimal' && this.tipoSalida == 'binario') {
      resultado = int.parse(this.cantidad).toRadixString(2);
    }
    if (this.tipoEntrada == 'decimal' && this.tipoSalida == 'hexadecimal') {
      resultado = int.parse(this.cantidad).toRadixString(16).toUpperCase();
    }
    if (this.tipoEntrada == 'decimal' && this.tipoSalida == 'octal') {
      resultado = int.parse(this.cantidad).toRadixString(8);
    }

    if (this.tipoEntrada == 'binario' && this.tipoSalida == 'decimal') {
      resultado = binarioToDecimal();
    }

    if (this.tipoEntrada == 'binario' && this.tipoSalida == 'hexadecimal') {
      String tmp = binarioToDecimal();
      resultado = int.parse(tmp).toRadixString(16).toUpperCase();
    }

    if (this.tipoEntrada == 'binario' && this.tipoSalida == 'octal') {
      String tmp = binarioToDecimal();
      resultado = int.parse(tmp).toRadixString(8);
    }

    if (this.tipoEntrada == 'octal' && this.tipoSalida == 'decimal') {
      resultado = octalToDecimal();
    }

    if (this.tipoEntrada == 'octal' && this.tipoSalida == 'binario') {
      resultado = int.parse(octalToDecimal()).toRadixString(2);
    }

    if (this.tipoEntrada == 'octal' && this.tipoSalida == 'hexadecimal') {
      resultado = int.parse(octalToDecimal()).toRadixString(16).toUpperCase();
    }

    if (this.tipoEntrada == 'hexadecimal' && this.tipoSalida == 'decimal') {
      resultado = hexaToDecimal();
    }

    if (this.tipoEntrada == 'hexadecimal' && this.tipoSalida == 'binario') {
      resultado = int.parse(hexaToDecimal()).toRadixString(2);
    }

    if (this.tipoEntrada == 'hexadecimal' && this.tipoSalida == 'octal') {
      resultado = int.parse(hexaToDecimal()).toRadixString(8);
    }

    return resultado;
  }
}
