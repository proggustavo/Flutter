import 'package:flutter/material.dart';

Widget TitleCity(String city) {
  return Text(city, style: TextStyle(color: Colors.white, fontSize: 25));
}

Widget Subtitle(String text) {
  return Text(text, style: TextStyle(color: Colors.white, fontSize: 20));
}

Widget InfoWeatherDefault(
    String title1, String info1, String title2, String info2) {
  return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title1,
                style: TextStyle(color: Colors.white),
              ),
              Text(info1, style: TextStyle(color: Colors.white))
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 20)),
          Column(
            children: [
              Text(title2, style: TextStyle(color: Colors.white)),
              Text(info2, style: TextStyle(color: Colors.white))
            ],
          )
        ],
      )
    );
}
