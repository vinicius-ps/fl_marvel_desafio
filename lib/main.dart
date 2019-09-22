import 'package:fl_desafio_marvel/screens/home.page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(home: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutership - Desafio Marvel',
      theme: ThemeData(
        brightness: Brightness.dark,

        primarySwatch: Colors.grey,
        primaryColor: Colors.grey[50],
        primaryColorBrightness: Brightness.light,

        accentColor: Colors.red,
        accentColorBrightness: Brightness.light,
      ),
      home: MyHomePage(title: 'MARVEL'),
    );
  }
}
