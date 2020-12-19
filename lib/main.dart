import 'package:conversor/moeda.dart';
import 'package:conversor/teste.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=ed0e5683";
void main() async {
  runApp(MaterialApp(
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          labelStyle: TextStyle(color: Colors.amber),
          hintStyle: TextStyle(color: Colors.white),
          prefixStyle: TextStyle(color: Colors.amber, fontSize: 25),
        ),
      )));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map> _future;

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  http.Response response;
  Future<Map> getData() async {
    if (response == null) {
      response = await http.get(request);
    }
    return json.decode(response.body);
  }

  //final realController = TextEditingController();
  //final dolarController = TextEditingController();
  //final euroController = TextEditingController();

  final moedaController1 = TextEditingController();
  final moedaController2 = TextEditingController();

  var moedaS1 = 1.0;
  var moedaS2 = 2.0;
  var resultado;

  double dolar;
  double euro;

  void _moedaChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double entrada;
    double saida;

    if (moedaS1 == 2.0) {
      entrada = dolar;
    } else if (entrada == 3.0) {
      entrada = euro;
    } else {
      entrada = moedaS1;
    }

    if (moedaS2 == 2.0) {
      saida = dolar;
    } else if (moedaS2 == 3.0) {
      saida = euro;
    } else {
      saida = moedaS2;
    }

    double valor = double.parse(text);

    moedaController2.text = (valor * entrada / saida).toStringAsFixed(2);
  }

/*
  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }
*/
  void _clearAll() {
    moedaController1.text = "";
    moedaController2.text = "";
  }

  var listaMoedas = [
    DropdownMenuItem(
      child: Text("Real"),
      value: 1.0,
    ),
    DropdownMenuItem(
      child: Text("Dolar"),
      value: 2.0,
    ),
    DropdownMenuItem(
      child: Text("Euro"),
      value: 3.0,
    ),
  ];
/*
  void gerarDDList(double dolar, double euro) {
    listaMoedas.clear();

    listaMoedas = [
      DropdownMenuItem(
        child: Text("Real"),
        value: "1.0",
      ),
      DropdownMenuItem(
        child: Text("Dolar"),
        value: "2.0",
      ),
      DropdownMenuItem(
        child: Text("Euro"),
        value: "3.0",
      ),
    ];

    moedaS2 = "1.0";
    moedaS1 = "2.0";

    listaMoedas.add(DropdownMenuItem(
      child: Text("Dolar"),
      value: "2.0",
    ));

    listaMoedas.add(
      DropdownMenuItem(
        child: Text("Euro"),
        value: "3.0",
      ),
    );
    
  }
*/
/*
  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

      // start the SecondScreen and wait for it to finish with a result
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaginaMoeda(),
          ));

      // after the SecondScreen result comes back update the Text widget with it
      setState(() {
        listaMoedas = result;
      });
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: _future,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao Carregar Dados :(",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                //  gerarDDList(dolar, euro);

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      Text(
                        "Converter de:",
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                      DropdownButton(
                        items: listaMoedas,
                        onChanged: (moeda) {
                          setState(() {
                            moedaS1 = moeda;
                          });
                          _moedaChanged(moedaController1.text);
                        },
                        value: moedaS1,
                        style: TextStyle(fontSize: 22.0, color: Colors.amber),
                      ),
                      buildTextField("", "", moedaController1, _moedaChanged),
                      Divider(),
                      Text(
                        "Para:",
                        style: TextStyle(color: Colors.amber, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                      DropdownButton(
                        items: listaMoedas,
                        onChanged: (moeda) {
                          setState(() {
                            moedaS2 = moeda;
                          });
                          _moedaChanged(moedaController1.text);
                        },
                        value: moedaS2,
                        style: TextStyle(fontSize: 22.0, color: Colors.amber),
                      ),
                      TextField(
                        controller: moedaController2,
                        enabled: false,
                        decoration: InputDecoration(
                          // labelText: label,
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.amber),
                          // prefixText: prefixo
                        ),
                        style: TextStyle(color: Colors.amber, fontSize: 20.0),
                      ),

                      //   buildTextField(
                      //      "Euros", "€", moedaController2, _euroChanged),
                      Divider(),
                      RaisedButton(
                        onPressed: () {
                          _awaitReturnValueFromSecondScreen(context);
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaginaMoeda(ddbList: listaMoedas,)),
                          );*/
                        },
                        child: Text(
                          "Criar Nova Moeda",
                          style: TextStyle(fontSize: 25.0, color: Colors.black),
                        ),
                        color: Colors.amber,
                      )
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaMoeda(
            ddbList: listaMoedas,
          ),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      listaMoedas = result;
    });
  }
}

Widget buildTextField(
    String label, String prefixo, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.amber),
        prefixText: prefixo),
    style: TextStyle(color: Colors.amber, fontSize: 20.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
