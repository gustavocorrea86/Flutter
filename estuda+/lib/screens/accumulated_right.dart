import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/widgets/animated_button_progress.dart';
import 'package:flutter/material.dart';

import 'package:estudamais/models/model_right.dart';
import 'package:provider/provider.dart';

class AccumulatedRight extends StatefulWidget {
  const AccumulatedRight({super.key});

  @override
  State<AccumulatedRight> createState() => _AccumulatedRightState();
}

class _AccumulatedRightState extends State<AccumulatedRight> {
  bool checked = false;
  QuestionsCorrects questionsCorrectsDb = QuestionsCorrects();

  onChecked() {
    setState(() {
      //checked = !checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelNumberOfSubject>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acertos acumulados'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color.fromARGB(188, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          QuestionsCorrects.listDisciplinesCorrect.length,
                      itemBuilder: (context, int index) {
                        return AnimatedButtonProgress(
                          discipline:
                              QuestionsCorrects.listDisciplinesCorrect[index],
                              listMap: QuestionsCorrects.resultQuestionsCorrect,
                          
                          
                      
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// QuestionsCorrects.listDisciplinesCorrect[index],
//                             () {
//                           questionsCorrectsDb
//                               .showSubjectsAndSchoolyeaCorrects(QuestionsCorrects.listDisciplinesCorrect[index]);
//                         }, QuestionsCorrects.mapListSubAndYearCorrects.length,  QuestionsCorrects.mapListSubAndYearCorrects[index]['subjects'], QuestionsCorrects.mapListSubAndYearCorrects[index]
//                     ['schoolYear']
