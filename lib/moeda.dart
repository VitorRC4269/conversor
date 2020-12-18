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
  @override
  _PaginaMoedaState createState() => _PaginaMoedaState();
}

class _PaginaMoedaState extends State<PaginaMoeda> {
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
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
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
}
