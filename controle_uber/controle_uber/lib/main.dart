import 'package:controle_uber/database/dao_controller.dart';
import 'package:controle_uber/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Corridas',
      home: Home(),
    );
  }
}
