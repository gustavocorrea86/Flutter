import 'package:flutter/material.dart';

class ScreenQuestions extends StatefulWidget {
  final Widget boxQuestions;
  final Widget boxAlternativesA;
  final Widget boxAlternativesB;
  final Widget boxAlternativesC;
  final Widget boxAlternativesD;
  final PageController controller;

  const ScreenQuestions(
      this.boxQuestions,
      this.boxAlternativesA,
      this.boxAlternativesB,
      this.boxAlternativesC,
      this.boxAlternativesD,
      this.controller,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.2, 1),
                colors: <Color>[
              Colors.indigo,
              Colors.lightBlue,
              Colors.indigo,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                color: Colors.amber,
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(.2, 1),
                                    colors: <Color>[
                                      Colors.amber,
                                      Colors.yellow,
                                      Colors.amber
                                    ]),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        './assets/images/finance-634901_640.png'),
                                    fit: BoxFit.cover,
                                    opacity: .2)),
                            child: Column(
                              children: [
                                Text(
                                  '1000',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(
                              './assets/images/ball-7280265_640.jpg'),
                          fit: BoxFit.cover,
                          opacity: 0.2),
                      boxShadow: [
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
                              'Questão 0 / 10',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.green[300],
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(1, 2),
                                            blurRadius: 1,
                                            spreadRadius: 1)
                                      ],
                                    ),
                                    child: Text(
                                      '+1',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.red[300],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(1, 2),
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ],
                                  ),
                                  child: Text(
                                    '-2',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          color: Colors.black26,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
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
                                duration: Duration(microseconds: 500),
                                curve: Curves.ease);
                          },
                          child: Text('Próximo')),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Voltar',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Sair',
                                  style: TextStyle(color: Colors.black),
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
      ),
    );
  }
}
