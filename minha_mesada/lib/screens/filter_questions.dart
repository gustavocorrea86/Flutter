import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minha_mesada/widgets/dropdown_filter.dart';

class FilterQuestions extends StatefulWidget {
  const FilterQuestions({super.key});

  @override
  State<FilterQuestions> createState() => _FilterQuestionsState();
}

class _FilterQuestionsState extends State<FilterQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matemática'),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                fit: BoxFit.cover),
          ),
          const Row(
            children: <Widget>[
              DropdownFilter('serie'),
              DropdownFilter('assunto'),
            ],
          )
        ],
      ),
    );
  }
}
