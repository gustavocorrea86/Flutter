import 'package:estudamais/widgets/box_schoolYear.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';
import 'package:provider/provider.dart';

class GridList extends StatefulWidget {
  // final List<String>? listSerie;
  // final List<String>? listSubjects;
  // final String namePage;
  const GridList({super.key});
  //const GridList(this.namePage, {this.listSerie, this.listSubjects, super.key});

  @override
  State<GridList> createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: const <Widget>[
          BoxSchoolyear('1º Ano', '1º Ano', '1ano'),
          BoxSchoolyear('2º Ano', '2º Ano', '2ano'),
          BoxSchoolyear('3º Ano', '3º Ano', '3ano'),
          BoxSchoolyear('4º Ano', '4º Ano', '4ano'),
          BoxSchoolyear('5º Ano', '5º Ano', '5ano'),
          BoxSchoolyear('6º Ano', '6º Ano', '6ano'),
          BoxSchoolyear('7º Ano', '7º Ano', '7ano'),
          BoxSchoolyear('8º Ano', '8º Ano', '8ano'),
          BoxSchoolyear('9º Ano', '9º Ano', '9ano'),
        ],
      );
    });
  }
}
