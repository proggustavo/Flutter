import 'package:flutter/material.dart';
import 'package:flutter_app_imc/quotation.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConversorPage extends StatefulWidget {
  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  int index = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerValor = TextEditingController();
  String valor = "";
  var maskFormatterMoney = new MaskTextInputFormatter(
      mask: '###,###', filter: {"#": RegExp(r'[0-9]')});
  String valorDolar = "";
  String valorEuro = "";
  var _quotations = <Quotation>[];
  Quotation dolarQuotation;
  // double euroQuotation = double.parse(_quotations[1].)


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    String url = "https://economia.awesomeapi.com.br/all";
    http.Response response = await http.get(url);
    setState(() {
      final valuesJson = jsonDecode(response.body);
      _quotations.add(Quotation(
          valuesJson["USD"]["name"], valuesJson["USD"]["code"],
          valuesJson["USD"]["bid"], valuesJson["USD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["EUR"]["name"], valuesJson["EUR"]["code"],
          valuesJson["EUR"]["bid"], valuesJson["EUR"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["USDT"]["name"], valuesJson["USDT"]["code"],
          valuesJson["USDT"]["bid"], valuesJson["USDT"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CAD"]["name"], valuesJson["CAD"]["code"],
          valuesJson["CAD"]["bid"], valuesJson["CAD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["GBP"]["name"], valuesJson["GBP"]["code"],
          valuesJson["GBP"]["bid"], valuesJson["GBP"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["ARS"]["name"], valuesJson["ARS"]["code"],
          valuesJson["ARS"]["bid"], valuesJson["ARS"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["BTC"]["name"], valuesJson["BTC"]["code"],
          valuesJson["BTC"]["bid"], valuesJson["BTC"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["LTC"]["name"], valuesJson["LTC"]["code"],
          valuesJson["LTC"]["bid"], valuesJson["LTC"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["JPY"]["name"], valuesJson["JPY"]["code"],
          valuesJson["JPY"]["bid"], valuesJson["JPY"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CHF"]["name"], valuesJson["CHF"]["code"],
          valuesJson["CHF"]["bid"], valuesJson["CHF"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["AUD"]["name"], valuesJson["AUD"]["code"],
          valuesJson["AUD"]["bid"], valuesJson["AUD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CNY"]["name"], valuesJson["CNY"]["code"],
          valuesJson["CNY"]["bid"], valuesJson["CNY"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["ETH"]["name"], valuesJson["ETH"]["code"],
          valuesJson["ETH"]["bid"], valuesJson["ETH"]["ask"]));

      dolarQuotation = Quotation(
          valuesJson["USD"]["name"], valuesJson["USD"]["code"],
          valuesJson["USD"]["bid"], valuesJson["USD"]["ask"]);
      print(_quotations);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            setState(() {
              valor = "";
              valorDolar = "";
              valorEuro = "";
              _controllerName.text = "";
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
                      controller: _controllerName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nome",
                          icon: Icon(Icons.account_circle,
                              textDirection: TextDirection.ltr)),
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
                Padding(padding: EdgeInsets.only(top: 60, bottom: 20), child: Text("$valorDolar", style:  TextStyle(height: 5, fontSize: 20))),
                Text("$valorEuro", style: TextStyle(height: 5, fontSize: 20)),
              ],
            ),
          )
      ),
    );
  }
}
