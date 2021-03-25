import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_imc/quotation.dart';

class QuotationsPage extends StatefulWidget {
  @override
  _QuotationsPageState createState() => _QuotationsPageState();
}

class _QuotationsPageState extends State<QuotationsPage> {
  var _quotations = <Quotation>[];
  Quotation dolarQuotation;
  final _font = const TextStyle(fontSize: 20.0);

  _loadData() async {
    String url = "https://economia.awesomeapi.com.br/all";
    http.Response response = await http.get(url);
    setState(() {
      final valuesJson = jsonDecode(response.body);
      _quotations.add(Quotation(
          valuesJson["USD"]["name"],
          valuesJson["USD"]["code"],
          valuesJson["USD"]["bid"],
          valuesJson["USD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["EUR"]["name"],
          valuesJson["EUR"]["code"],
          valuesJson["EUR"]["bid"],
          valuesJson["EUR"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["USDT"]["name"],
          valuesJson["USDT"]["code"],
          valuesJson["USDT"]["bid"],
          valuesJson["USDT"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CAD"]["name"],
          valuesJson["CAD"]["code"],
          valuesJson["CAD"]["bid"],
          valuesJson["CAD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["GBP"]["name"],
          valuesJson["GBP"]["code"],
          valuesJson["GBP"]["bid"],
          valuesJson["GBP"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["ARS"]["name"],
          valuesJson["ARS"]["code"],
          valuesJson["ARS"]["bid"],
          valuesJson["ARS"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["BTC"]["name"],
          valuesJson["BTC"]["code"],
          valuesJson["BTC"]["bid"],
          valuesJson["BTC"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["LTC"]["name"],
          valuesJson["LTC"]["code"],
          valuesJson["LTC"]["bid"],
          valuesJson["LTC"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["JPY"]["name"],
          valuesJson["JPY"]["code"],
          valuesJson["JPY"]["bid"],
          valuesJson["JPY"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CHF"]["name"],
          valuesJson["CHF"]["code"],
          valuesJson["CHF"]["bid"],
          valuesJson["CHF"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["AUD"]["name"],
          valuesJson["AUD"]["code"],
          valuesJson["AUD"]["bid"],
          valuesJson["AUD"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["CNY"]["name"],
          valuesJson["CNY"]["code"],
          valuesJson["CNY"]["bid"],
          valuesJson["CNY"]["ask"]));
      _quotations.add(Quotation(
          valuesJson["ETH"]["name"],
          valuesJson["ETH"]["code"],
          valuesJson["ETH"]["bid"],
          valuesJson["ETH"]["ask"]));

      _quotations.add(Quotation(
          valuesJson["XRP"]["name"],
          valuesJson["XRP"]["code"],
          valuesJson["XRP"]["bid"],
          valuesJson["XRP"]["ask"]));

      dolarQuotation = Quotation(
          valuesJson["USD"]["name"],
          valuesJson["USD"]["code"],
          valuesJson["USD"]["bid"],
          valuesJson["USD"]["ask"]);
      print(_quotations);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget _buildRow(BuildContext context, int position) {
    return ListTile(
      title: Text(
        "${_quotations[position].currencyName} - ${_quotations[position].bid}",
        style: _font,
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Quotations"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _quotations.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(context, position);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.white),
      ),
    );
  }
}
