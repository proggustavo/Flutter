import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int __contador = 0;
  String informacao = "";

  void _incrementCounter() {
    setState(() {
      __contador++;
    });
    }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/restaurant.jpg",
          fit: BoxFit.fill,
          height: 800,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seja Bem-vindo",
              style: TextStyle(fontSize: 35),
            ),
            Text("Pessoas: $__contador" , style: TextStyle(fontSize: 25)),
            Text('$informacao' , style: TextStyle(fontSize: 25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: botaoPadrao("-1", -1),
                ),
                botaoPadrao("+1", 1)
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget botaoPadrao(String texto, int index) {
    return FlatButton(
        color: Colors.blueAccent,
        child:
            Text(texto, style: TextStyle(color: Colors.white, fontSize: 30)),
        onPressed: () {
          setState(() {
            if(__contador <= 0 && texto.contains("-")){
              informacao = "Restaurante lotado!";
              return;
            }else if(__contador >= 10 && texto.contains("+")){
              informacao = "Casa Cheia";
              return;
            }else{
              informacao = "";
            }
            __contador += index;
          });
        });
  }
}
