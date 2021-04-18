import 'package:flutter/material.dart';
import 'package:my_weather/weather.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Weather(_currentIndex),
      backgroundColor: Colors.blueAccent,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: "Florianópolis",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: "Biguaçu",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: "São José",
            ),
          ]),
    );
  }
}
