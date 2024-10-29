import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:mongodb_api/service/service.dart';
import 'package:mongodb_api/widgets/screen_questions.dart';
import 'package:provider/provider.dart';

class BoxAlternatives extends StatefulWidget {
  // final Color cor;
  final String alt;
  final String option;
  final String response;

  final bool isAnswered;
  final int indexQuestion;

  const BoxAlternatives(
      this.alt, this.option, this.response, this.isAnswered, this.indexQuestion,
      {super.key});

  @override
  State<BoxAlternatives> createState() => _BoxAlternativesState();
}

class _BoxAlternativesState extends State<BoxAlternatives> {
  DaoUserResum database = DaoUserResum();
  Color corAlternativa = Colors.white;
  String currentPoint = '';
  String currentErrors = '';
  String currentAnswered = '';
  int pointHit = 0;

  int countErros = 0;

  String hitOrErr = '';

  double heightContainer = 0;
  bool? answered;
  double widthContainer = 0;
  double heightBoxIsAnswered = 0;
  List wrongQuestion = [];
  List hitQuestion = [];

  void answereds() {
    currentAnswered = DaoUserResum.answeredQuestions;
    int answeredQuestions = int.parse(currentAnswered) + 1;
    database.updateAnswereds(answeredQuestions.toString(), currentAnswered);
    currentAnswered = answeredQuestions.toString();
    Provider.of<ModelPoints>(context, listen: false)
        .counterOfAnswereds(currentAnswered);
  }

  void counterPoints() {
    currentPoint = DaoUserResum.totalPoints;
    int countPoint = int.parse(currentPoint) + 1;
    database.updatePoints(countPoint.toString(), currentPoint);
    currentPoint = countPoint.toString();
    Provider.of<ModelPoints>(context, listen: false).showPoints(currentPoint);
  }

  void counterErrors() {
    currentErrors = DaoUserResum.totalErrors;
    int countError = int.parse(currentErrors) + 1;
    database.updateErrors(countError.toString(), currentErrors);
    currentErrors = countError.toString();
    Provider.of<ModelPoints>(context, listen: false).showErrors(currentErrors);
  }

  void isCorrect() {
    if (widget.isAnswered) {
      heightBoxIsAnswered = 30;
    } else {
      if (widget.response == widget.alt) {
        corAlternativa = Colors.green;
        print('index da questão: ${widget.indexQuestion}');

        hitQuestion.add(Service.result[widget.indexQuestion]);
        print(hitQuestion);
        Counter().counterOfPoints();
        hitOrErr = 'Acertou!';
        widthContainer = 70;
        heightContainer = 20;
        counterPoints();
        answereds();
      } else {
        wrongQuestion.add(Service.result[widget.indexQuestion]);
        print(wrongQuestion);

        counterErrors();
        print('index da questão: ${widget.indexQuestion}');
        Counter().counterOfErrors();
        corAlternativa = Colors.red;

        hitOrErr = 'Errou';
        widthContainer = 70;
        heightContainer = 20;
        answereds();
      }
    }
  }

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
                    color: corAlternativa,
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
                        widget.alt,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        answered = true;
                        isCorrect();
                        value.actBoxAnswered(heightBoxIsAnswered);
                        value.answered(answered!);
                        value.pointsHits(pointHit.toString());
                        value.errors(countErros.toString());
                      });
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
                        width: widthContainer,
                        height: heightContainer,
                        decoration: BoxDecoration(
                            color: corAlternativa,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          hitOrErr,
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
