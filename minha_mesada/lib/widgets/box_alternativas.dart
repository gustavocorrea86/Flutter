import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:provider/provider.dart';

class BoxAlternatives extends StatefulWidget {
  // final Color cor;
  final String alt;
  final String option;
  final String response;
  final String? correct;
  final bool isAnswered;

  const BoxAlternatives(this.alt, this.option, this.response, this.isAnswered,
      {this.correct, super.key});

  @override
  State<BoxAlternatives> createState() => _BoxAlternativesState();
}

class _BoxAlternativesState extends State<BoxAlternatives> {
  DaoUserResum databasePoints = DaoUserResum();
  Color corAlternativa = Colors.white;
  String currentPoint = '';

  static int pointHit = 0;
  static int countErros = 0;

  String hitOrErr = '';

  double heightContainer = 0;
  bool? answered;
  double widthContainer = 0;
  double heightBoxIsAnswered = 0;

  int countPoints() {
    pointHit++;
    return pointHit;
  }

  int countErrors() {
    countErros++;
    return countErros;
  }

  @override
  void initState() {
    super.initState();
    // answered = false;
    currentPoint = DaoUserResum.totalPoints;
  }

  isCorrect() {
    if (widget.isAnswered) {
      heightBoxIsAnswered = 30;
      print('widget.isAnswered = ${widget.isAnswered}');
      print('answered = $answered');
    } else {
      if (widget.response == widget.alt) {
        corAlternativa = Colors.green;
        countPoints();
        currentPoint = DaoUserResum.totalPoints;
        print('currentPoints = $currentPoint');
        print('widget.isAnswered = ${widget.isAnswered}');
        print('answered = $answered');
        databasePoints.updatePoints(pointHit.toString(), currentPoint);
        
        hitOrErr = 'Acertou!';
        widthContainer = 70;
        heightContainer = 20;
      } else {
        print('widget.isAnswered = ${widget.isAnswered}');
        print('answered = $answered');
        
        corAlternativa = Colors.red;
        countErrors();
        print('Erros:$countErros');
        hitOrErr = 'Errou';
        widthContainer = 70;
        heightContainer = 20;
      }
    }

    return Text(hitOrErr);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Consumer<ModelPoints>(builder: (context, value, child) {
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
                        if (widget.response == widget.alt) {
                          value.showPoints(currentPoint);
                        }
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
        }));
  }
}
