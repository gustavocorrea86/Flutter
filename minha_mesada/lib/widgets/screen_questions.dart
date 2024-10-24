import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
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

  const ScreenQuestions(
      this.boxQuestions,
      this.boxAlternativesA,
      this.boxAlternativesB,
      this.boxAlternativesC,
      this.boxAlternativesD,
      this.controller,
      this.qdtQuestoes,
      this.question,
      // this.index,
      {super.key});

  @override
  State<ScreenQuestions> createState() => _ScreenQuestionsState();
}

class _ScreenQuestionsState extends State<ScreenQuestions> {
  Color corAlternativa = Colors.white;
  double heightAnswered = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ModelPoints>(builder: (context, value, child) {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text('Pontos'),
                                  const Text('Totais'),
                                  Text(value.hits)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text('Pontos'),
                                  const Text('Acumulados'),
                                  Text(value.pointsDb)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 70,
                                child: Column(
                                  children: [Text('Erros'), Text('Totais')],
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage(
                              './assets/images/ball-7280265_640.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.2),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Questão ${widget.question + 1} / ${widget.qdtQuestoes}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            const PointsAndErrors()
                          ],
                        ),
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
                        child: Container(
                          height: value.boxIsAnswered,
                          child: Text(
                            'Pergunta já respondida!',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 145, 18, 9)),
                          ),
                        ),
                      )
                    ],
                  ),
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
                        padding: const EdgeInsets.only(top: 20),
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
    }));
  }
}
// decoration: BoxDecoration(
                        //   border: Border.all(width: 1, color: Colors.white),
                        //   color: Colors.amber,
                        //   gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment(.2, 1),
                        //       colors: <Color>[
                        //         Colors.amber,
                        //         Colors.yellow,
                        //         Colors.amber
                        //       ]),
                        //   shape: BoxShape.circle,
                        //   image: DecorationImage(
                        //       image: AssetImage(
                        //           './assets/images/finance-634901_640.png'),
                        //       fit: BoxFit.cover,
                        //       opacity: .2),
                        // ),