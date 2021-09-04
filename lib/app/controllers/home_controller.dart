import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  var request =
      "https://api.hgbrasil.com/finance?format=json-cors&key=3c3b448c";

  @observable
  String real;

  @observable
  String dolar;

  @observable
  String euro;

  double dolarD;
  double euroE;

  @action
  void setReal(String value) => real = value;

  @action
  void seDolar(String value) => dolar = value;

  @action
  void setEuro(String value) => euro = value;

  @action
  void dolarChanged(String text) {
    _textEmpty(text);

    double dolar = double.parse(text);

    real = (dolar * this.dolarD).toStringAsFixed(2);
    euro = (dolar * this.dolarD / euroE).toStringAsFixed(2);
  }

  void _textEmpty(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
  }

  void _clearAll() {
    real = "";
    dolar = "";
    euro = "";
  }

  @action
  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }
}
