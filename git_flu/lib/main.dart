import 'package:flutter/material.dart';
import 'package:git_flu/mywidget.dart';

void main() => runApp(GitFluApp());

class GitFluApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "GitFlu",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Titulo do App")
        ),
        body: Center(
          child: GitFluWidget(),
        )
      ),
    );
  }
}



