import 'package:flutter/material.dart';
import 'movie_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Le Cinéphile',
      home: new MovieList(),
    );
  }
}