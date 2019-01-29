import 'package:flutter/material.dart';
import 'downtownapp.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    String tmp = 'FromDowntown';
    return new MaterialApp(
      title: tmp,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: CurvePage(),
      home: DowntownPage(),
    );
  }
}


