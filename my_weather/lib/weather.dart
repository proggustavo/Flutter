import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather extends StatefulWidget {
  int index;
  Weather(this.index);
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  List<String> urls = [
    "https://api.hgbrasil.com/weather?woeid=455861",
    "https://api.hgbrasil.com/weather?woeid=458705",
    "https://api.hgbrasil.com/weather?woeid=450398",
  ];

  Future<Map> _getData(int currentIndex) async {
    print("Esse é o index " + currentIndex.toString());
    http.Response res = await http.get(urls[currentIndex]);
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: myFutureBuilder(),
    );
  }

  Widget myFutureBuilder() {
    return FutureBuilder(
        future: _getData(this.widget.index),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Carregando Dados",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              );
            default:
              if (snapshot.hasError) {
                return Text("Error para carregar dados");
              }
              return myColumn(snapshot.data);
          }
        });
  }

  Widget myColumn(Map data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 110),
            child: Icon(
              Icons.cloud,
              size: 170,
              color: Colors.white,
            )),
        Column(
          children: [
            Text(
              data["results"]["city"],
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              data["results"]["description"],
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
        myRow("Temperatura", data["results"]["temp"].toString() + "°",
            "Umidade", data["results"]["humidity"].toString() + "%"),
        myRow("Nascer do Sol", data["results"]["sunrise"], "Pôr do sol",
            data["results"]["sunset"]),
        myRow("Vel. Vento", data["results"]["wind_speedy"], "Condição",
            data["results"]["condition_slug"]),
      ],
    );
  }

  Widget myRow(String title1, String info1, String title2, String info2) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(children: [
            Text(
              title1,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              info1,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ]),
          Padding(padding: EdgeInsets.only(left: 40)),
          Column(children: [
            Text(
              title2,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Text(
              info2,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ]),
        ])
      ]),
    );
  }
}
