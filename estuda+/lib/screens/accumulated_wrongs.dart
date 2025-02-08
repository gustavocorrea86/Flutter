import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/widgets/animated_button_progress.dart';
import 'package:flutter/material.dart';

import 'package:estudamais/models/model_right.dart';
import 'package:provider/provider.dart';

class AccumulatedWrongs extends StatefulWidget {
  const AccumulatedWrongs({super.key});

  @override
  State<AccumulatedWrongs> createState() => _AccumulatedWrongsState();
}

class _AccumulatedWrongsState extends State<AccumulatedWrongs> {
  bool checked = false;
  QuestionsIncorrects questionsIncorrectsDb = QuestionsIncorrects();

  onChecked() {
    setState(() {
      checked = !checked;
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
                          QuestionsIncorrects.listDisciplinesIncorrect.length,
                      itemBuilder: (context, int index) {
                        return AnimatedButtonProgress(
                          discipline: QuestionsIncorrects
                              .listDisciplinesIncorrect[index],
                         listMap: QuestionsIncorrects.resultQuestionsIncorrect,
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
