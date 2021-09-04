import 'package:conversordemoeda/app/components/text_input.dart';
import 'package:conversordemoeda/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();

  //TODO: Criar observables
  final realControler = TextEditingController();
  final dolarControler = TextEditingController();
  final euroControler = TextEditingController();

  //TODO: Colocar dentro do HomeController
  double dolar;
  double euro;

  void _realChanged(String text) {
    _textEmpty(text);

    double real = double.parse(text);
    dolarControler.text = (real / dolar).toStringAsFixed(2);
    euroControler.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    _textEmpty(text);

    double dolar = double.parse(text);

    realControler.text = (dolar * this.dolar).toStringAsFixed(2);
    euroControler.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    _textEmpty(text);

    double euro = double.parse(text);
    realControler.text = (euro * this.euro).toStringAsFixed(2);
    dolarControler.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _clearAll() {
    realControler.text = "";
    dolarControler.text = "";
    euroControler.text = "";
  }

  void _textEmpty(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(" \$ Conversor \$"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map>(
        future: homeController.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao Carregar Dados :(",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 125.0, color: Colors.amber),
                      TextInput(
                        label: 'Real',
                        onChanged: homeController.setReal,
                        prefix: 'R\$',
                      ),
                      buildTextFiled(
                          "Reais", "R\$ ", realControler, _realChanged),
                      Divider(),
                      buildTextFiled(
                          "Dolares", "US\$ ", dolarControler, _dolarChanged),
                      Divider(),
                      buildTextFiled("Euro", "€ ", euroControler, _euroChanged),
                      RaisedButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      })
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget buildTextFiled(
      String label, String prefix, TextEditingController c, Function function) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        prefixText: prefix,
      ),
      style: TextStyle(color: Colors.amber, fontSize: 25.0),
      onChanged: function,
      keyboardType: TextInputType.number,
    );
  }
}
