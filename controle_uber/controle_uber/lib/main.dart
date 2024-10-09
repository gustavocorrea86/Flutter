import 'package:controle_uber/database/dao_controller.dart';
import 'package:controle_uber/models/model_datas.dart';
import 'package:controle_uber/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  // DaoDrivesControl().save(ModelDatas('09', '300', '110', '12hs', '21hs'));
  DaoDrivesControl().findAll();
  // DaoDrivesControl().delete();
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
