import 'package:flutter/material.dart';
import './utils.dart';

class SaoJose extends StatefulWidget {
  @override
  _SaoJoseState createState() => _SaoJoseState();
}

class _SaoJoseState extends State<SaoJose> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Icon(
                Icons.cloud, 
                size: 130, 
                color: Colors.white,
              ),
          ])
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                TitleCity("São José, SC"),
                Subtitle("Parcialmente Nublado"),
                ],
            )
          ],
        ),
        InfoWeatherDefault("Temperatura", "22°", "Umidade", "68%"),
        InfoWeatherDefault("Vel. Vento", "6.69 km/h", "Condição", "Nubladoo"),
        InfoWeatherDefault("Nascer do sol", "6:23", "Pôr Do Sol", "18:11")


      ]
    );
  }
}