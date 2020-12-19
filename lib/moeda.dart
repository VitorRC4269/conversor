import 'package:conversor/main.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=ed0e5683";
void main() async {
  runApp(MaterialApp(
      home: PaginaMoeda(),
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

class PaginaMoeda extends StatefulWidget {
  final List<DropdownMenuItem<double>> ddbList;

  PaginaMoeda({List<DropdownMenuItem<double>> ddbList})
      : this.ddbList = ddbList ?? [];

  @override
  _PaginaMoedaState createState() => _PaginaMoedaState();
}

class _PaginaMoedaState extends State<PaginaMoeda> {
  final nomeController = TextEditingController();
  final valorController = TextEditingController();
  List ddbLista;

  void _clearAll() {
    nomeController.text = "";
    valorController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                "Nova moeda:",
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Divider(),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.amber),
                  //prefixText: prefixo
                ),
                style: TextStyle(color: Colors.amber, fontSize: 20.0),
                // onChanged: f,
                //keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Divider(),
              TextField(
                controller: valorController,
                decoration: InputDecoration(
                  labelText: "Valor",
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.amber),
                  // prefixText: prefixo
                ),
                style: TextStyle(color: Colors.amber, fontSize: 20.0),
                //onChanged: f,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Divider(),
              RaisedButton(
                onPressed: () {
                  ddbLista = widget.ddbList;
                  ddbLista.add(DropdownMenuItem(
                    child: Text(nomeController.text),
                    value: double.parse(valorController.text),
                  ));

                  _clearAll();
                },
                child: Text(
                  "Criar Nova Moeda",
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                color: Colors.amber,
              ),
              Divider(),
              RaisedButton(
                onPressed: () {
                  _sendDataBack(context, ddbLista);
                },
                child: Text(
                  "Voltar",
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                color: Colors.amber,
              )
            ],
          ),
        ));
  }

  void _sendDataBack(BuildContext context, List ddbL) {
    Navigator.pop(context, ddbL);
  }
}
