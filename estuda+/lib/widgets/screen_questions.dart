

import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/database/dao_wrong.dart';

import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/box_type_question.dart';
//import 'package:minha_mesada/widgets/box_resum_screenQuestions.dart';

import 'package:estudamais/widgets/pointsAndErrors.dart';
import 'package:provider/provider.dart';

class ScreenQuestions extends StatefulWidget {
  final Widget boxQuestions;
  final Image image;
  final Widget boxAlternativesA;
  final Widget boxAlternativesB;
  final Widget boxAlternativesC;
  final Widget boxAlternativesD;
  final PageController controller;
  final String qdtQuestoes;
  final int question;
  final String matter;
  final String subject;
  final String id;
  final String elementarySchool;
  final String series;

  const ScreenQuestions(
      this.boxQuestions,
      this.image,
      this.boxAlternativesA,
      this.boxAlternativesB,
      this.boxAlternativesC,
      this.boxAlternativesD,
      this.controller,
      this.qdtQuestoes,
      this.question,
      this.matter,
      this.subject,
      this.id,
      this.elementarySchool,
      this.series,
      {super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  Color corAlternativa = Colors.white;
  double heightAnswered = 0;
  DaoUserResum databeseUserResum = DaoUserResum();
  DaoRight databaseRight = DaoRight();
  DaoWrong databaseWrongs = DaoWrong();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 60.0, right: 8.0, bottom: 8.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(1, 3),
                              blurRadius: 1,
                              spreadRadius: 1)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ID Questão ${widget.id}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold),
                              ),
                              PointsAndErrors()
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: BoxTypeQuestion(
                            widget.elementarySchool,
                            widget.matter,
                            widget.series,
                            widget.subject,
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        widget.boxQuestions,
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: widget.image,
                          ),
                        )
                        ,
                        // SizedBox(
                        //   width: 150,
                        //   height: 150,
                        //   child: widget.image
                        // ),
                        widget.boxAlternativesA,
                        widget.boxAlternativesB,
                        widget.boxAlternativesC,
                        widget.boxAlternativesD,
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(
                            color: Colors.black26,
                            thickness: 1,
                            indent: 10,
                            endIndent: 10,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Center(
                            child: SizedBox(
                              height: value.boxIsAnswered,
                              child: const Text(
                                'Ops, essa você já respondeu!',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 145, 18, 9)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '* 1 ponto = R\$ 1,00',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          widget.controller.nextPage(
                              duration: const Duration(microseconds: 500),
                              curve: Curves.ease);
                          value.answered(false);
                          value.actBoxAnswered(0);
                        },
                        child: const Text('Próximo'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  widget.controller.animateToPage(
                                      widget.question - 1,
                                      duration:
                                          const Duration(microseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: const Text(
                                  'Voltar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  //databaseRight.findSubjectAsRight();
                                  //databaseRight.lenghtSubject();
                                  // databaseRight.findMatterAsRight();
                                  // databaseWrongs.findDispliceAsWrongs();
                                },
                                child: const Text(
                                  'Sair',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
