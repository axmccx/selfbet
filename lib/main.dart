import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Selfbet',
      home: new Scaffold(
        appBar:  new AppBar(
          title: new Text('Selfbet'),
        ),
        body: new Center(
          child: new Text('Welcome'),
        ),
      ),
    );
  }
}