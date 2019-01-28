import 'package:flutter/material.dart';
import 'downtownapp.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp(
      title: 'FromDowntown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: CurvePage(),
      home: DowntownPage(),
    );
  }
}


