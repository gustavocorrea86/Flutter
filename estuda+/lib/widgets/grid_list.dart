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
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        children: const <Widget>[
          BoxSchoolyear('Fundamental 1', '1º Ano', '1ano'),
          BoxSchoolyear('Fundamental 1','2º Ano', '2ano'),
          BoxSchoolyear('Fundamental 1','3º Ano', '3ano'),
          BoxSchoolyear('Fundamental 1','4º Ano', '4ano'),
          BoxSchoolyear('Fundamental 1','5º Ano', '5ano'),
          BoxSchoolyear('Fundamental 2','6º Ano', '6ano'),
          BoxSchoolyear('Fundamental 2','7º Ano', '7ano'),
          BoxSchoolyear('Fundamental 2','8º Ano', '8ano'),
          BoxSchoolyear('Fundamental 2','9º Ano', '9ano'),
        ],
      );
    });
  }
}
