import 'package:flutter/material.dart';
import 'package:flutter_lcinephil_dev/home.dart';
import 'movie_list.dart';
import 'auth/authentification.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ciné Fil',
      home: new Authentification(),
    );
  }
}