import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_imc/quotation.dart';




void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  final _formKey = GlobalKey<FormState>();
  // TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerValor = TextEditingController();
  String valor= "";
  var maskFormatterMoney = new MaskTextInputFormatter(
      mask: '###,###', filter: {"#": RegExp(r'[0-9]')});
  String valorDolar = "";
  String valorEuro = "";
  var _quotations = <Quotation>[];
  Quotation dolarQuotation;
  // double euroQuotation = double.parse(_quotations[1].)


  @override
  void initState(){
    super.initState();
    _loadData();
  }

  _loadData() async {
    String url = "https://economia.awesomeapi.com.br/all/USD-BRL,EUR-BRL";
    http.Response response = await http.get(url);

    setState(() {
      final valuesJson = jsonDecode(response.body);
      _quotations.add(Quotation(valuesJson["USD"]["name"], valuesJson["USD"]["code"], valuesJson["USD"]["bid"], valuesJson["USD"]["ask"]));
      _quotations.add(Quotation(valuesJson["EUR"]["name"], valuesJson["EUR"]["code"], valuesJson["EUR"]["bid"], valuesJson["EUR"]["ask"]));
      dolarQuotation = Quotation(valuesJson["USD"]["name"], valuesJson["USD"]["code"], valuesJson["USD"]["bid"], valuesJson["USD"]["ask"]);
      print(_quotations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Conversor de moedas'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            setState(() {
              // valor = "";
              // _controllerName.text = "";
              _controllerValor.text = "";
            });
          }),

        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                  child: TextFormField(
                    scrollPadding: const EdgeInsets.all(40.0),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nome",
                        icon: Icon(Icons.account_circle)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe seu nome';
                      }
                      return null;
                    },
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20, top: 20, bottom: 20),
                  child: TextFormField(
                    // inputFormatters: [maskFormatterMoney],
                    keyboardType: TextInputType.number,
                    scrollPadding: const EdgeInsets.all(40.0),
                    controller: _controllerValor,
                    maxLength: 5,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Valor em Reais",
                        icon: Icon(Icons.attach_money)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o valor';
                      }
                      return null;
                    },
                  )),
              ElevatedButton(
                onPressed: () {
                  double valor = double.parse(_controllerValor.text);
                  double dolar = valor / double.parse(_quotations[0].bid);
                  double euro = valor / double.parse(_quotations[1].bid);
                  setState(() {
                    valorDolar = "Valor em dólar é $dolar";
                    valorEuro = "Valor em euro é $euro";
                  });
                },
                child: Text("Converter"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black54, onPrimary: Colors.white),
              ),
              Text("$valorDolar"),
              Text("$valorEuro"),
            ],
          ),
        ),
      ),
    );
  }
}
