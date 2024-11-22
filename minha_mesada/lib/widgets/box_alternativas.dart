import 'package:flutter/material.dart';
import 'package:minha_mesada/controller/controller_questions.dart';
import 'package:minha_mesada/models/models.dart';
import 'package:provider/provider.dart';

class BoxAlternatives extends StatefulWidget {
  // final Color cor;
  final String alternative;
  final String option;
  final String response;
  final bool isAnswered;
  final int indexQuestion;

  const BoxAlternatives(this.alternative, this.option, this.response,
      this.isAnswered, this.indexQuestion,
      {super.key});

  @override
  State<BoxAlternatives> createState() => _BoxAlternativesState();
}

class _BoxAlternativesState extends State<BoxAlternatives> {
  final ControllerQuestions _controllerQuestions = ControllerQuestions();

  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Consumer<ModelPoints>(
        builder: (context, value, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: MediaQuery.of(context).size.width,
                  // height: 60,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 3),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                    color: _controllerQuestions.corAlternativa,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Colors.black38,
                    ),
                  ),
                  child: InkWell(
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.black26),
                            color: Colors.white),
                        child: Text(
                          widget.option,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      title: Text(
                        widget.alternative,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      answered = true;
                      _controllerQuestions.isCorrect(
                          widget.isAnswered,
                          widget.response,
                          widget.alternative,
                          widget.indexQuestion,
                          context);
                      value.actBoxAnswered(
                          _controllerQuestions.heightBoxIsAnswered);
                      value.answered(answered);
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        alignment: Alignment.center,
                        width: _controllerQuestions.widthContainer,
                        height: _controllerQuestions.heightContainer,
                        decoration: BoxDecoration(
                            color: _controllerQuestions.corAlternativa,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          _controllerQuestions.hitOrErr,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
