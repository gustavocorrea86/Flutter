import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_quizMath.dart';
import 'package:mongodb_api/widgets/box_alternativas.dart';
import 'package:mongodb_api/widgets/box_questions.dart';

class ScreenQuestions extends StatefulWidget {
  Widget boxQuestions;
  Widget boxAlternativesA;
  Widget boxAlternativesB;
  Widget boxAlternativesC;
  Widget boxAlternativesD;

  // PageController controller;
  // final int index;

  ScreenQuestions(this.boxQuestions, this.boxAlternativesA,
      this.boxAlternativesB, this.boxAlternativesC, this.boxAlternativesD,
      // this.controller,
      // this.index,
      {super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  Color corAlternativa = Colors.white;
  // List<Map<String, dynamic>> _pages = DaoQuiz().findAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('./assets/images/seamless-3249023_640.png'),
                  fit: BoxFit.cover,
                  opacity: .8),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.boxQuestions,
              widget.boxAlternativesA,
              widget.boxAlternativesB,
              widget.boxAlternativesC,
              widget.boxAlternativesD,
            ],
          )
        ],
      ),
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {
      //     widget.controller.animateToPage(widget.index+1,
      //         duration: Duration(milliseconds: 500), curve: Curves.ease);

      //   },
      //   child: Text('Próxima'),
      // ),
    );
  }
}
