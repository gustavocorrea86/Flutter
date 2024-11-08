import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_ritgh.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';

import 'package:mongodb_api/models/models.dart';
import 'package:mongodb_api/widgets/box_resum_screenQuestions.dart';

import 'package:mongodb_api/widgets/pointsAndErrors.dart';
import 'package:provider/provider.dart';

class ScreenQuestions extends StatefulWidget {
  final Widget boxQuestions;
  final Widget boxAlternativesA;
  final Widget boxAlternativesB;
  final Widget boxAlternativesC;
  final Widget boxAlternativesD;
  final PageController controller;
  final String qdtQuestoes;
  final int question;
  final String matter;
  final String subject;

  const ScreenQuestions(
      this.boxQuestions,
      this.boxAlternativesA,
      this.boxAlternativesB,
      this.boxAlternativesC,
      this.boxAlternativesD,
      this.controller,
      this.qdtQuestoes,
      this.question,
      this.matter,
      this.subject,
      {super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  Color corAlternativa = Colors.white;
  double heightAnswered = 0;
  DaoUserResum databeseUserResum = DaoUserResum();
  DaoRight databaseRight = DaoRight();

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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Pontos',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'Acumulados',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      BoxResumScreenQuestions(
                          value.pointsDb,
                          Image.asset(
                            './assets/images/checked.png',
                            width: 35,
                          ),
                          6.0),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Erros',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        const Text('Acumulados',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        BoxResumScreenQuestions(
                            value.errorsDb,
                            Image.asset(
                              './assets/images/checked_error.png',
                              width: 38,
                            ),
                            7.0),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Mesada',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Text(
                        'do Mês',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      BoxResumScreenQuestions(
                          'R\$ ${value.pointsDb},00',
                          Image.asset('./assets/images/notasDeDinheiro.png',
                              width: 60),
                          2.0)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Questão ${widget.question + 1} / ${widget.qdtQuestoes}',
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                          const PointsAndErrors()
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${widget.matter} / ${widget.subject}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 239, 99),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black26,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    widget.boxQuestions,
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
                      child: SizedBox(
                        height: value.boxIsAnswered,
                        child: const Text(
                          'Pergunta já respondida!',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 145, 18, 9)),
                        ),
                      ),
                    )
                  ],
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
                                    duration: const Duration(microseconds: 500),
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
                                databaseRight.findSubjectAsRight();
                                databaseRight.lenghtSubject();
                                databaseRight.findMatterAsRight();
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
      ));
    });
  }
}

class Counter {
  static int countPoints = 0;
  static int countErrors = 0;

  counterOfPoints() {
    countPoints++;
  }

  counterOfErrors() {
    countErrors++;
  }
}
