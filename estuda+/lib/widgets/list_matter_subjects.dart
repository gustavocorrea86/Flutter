import 'package:estudamais/service/questions_corrects.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/models/model_right.dart';
import 'package:estudamais/widgets/animated_button_progress.dart';

import 'package:provider/provider.dart';

class ListMatterAndSubjects extends StatefulWidget {
  String matter;
  bool? checked;
  List subjects;
  List lengthSubjects;
  List listOfRightSubject;

  ListMatterAndSubjects(
      this.matter, this.subjects, this.lengthSubjects, this.listOfRightSubject,
      {this.checked = false, super.key});

  @override
  State<ListMatterAndSubjects> createState() => _ListMatterAndSubjectsState();
}

class _ListMatterAndSubjectsState extends State<ListMatterAndSubjects> {
  bool select = false;
  bool enable = false;
  double paddingLeft1 = 10.0;
  double paddingLeft2 = 20.0;
  double paddingRight1 = 10.0;
  double paddingRight2 = 20.0;

  //DaoRight databaseRight = DaoRight();
  String noneSubject = '';
  double heightBoxNoneSubject = 0;

  //final Future? _future =
      
  void showBoxSubjects() {
    select = !select;
    print(select);
  }

  // Future<List> showSubjectsAndLength(String matter) async {
  //   _future = QuestionsCorrects().getSubjectsOfQuestionsCorrects(matter);
  //   if (_future == null) {
  //     heightBoxNoneSubject = 20;
  //     noneSubject = 'Nenhum assunto encontrado';
  //   }
  //   return await _future;
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelNumberOfSubject>(
      builder: (context, storageValue, child) {
        return ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  setState(
                    () {
                      showBoxSubjects();
                      if (select) {
                        print(widget.matter);
                        //showSubjectsAndLength(widget.matter);
                        QuestionsCorrects()
                            .getSubjectsOfQuestionsCorrects(widget.matter);
                        //boxHeight = 120;
                      } else {
                        widget.subjects.clear();
                        widget.lengthSubjects.clear();
                        widget.listOfRightSubject.clear();
                        //boxHeight = 0;
                      }
                    },
                  );
                },
                title: Text(widget.matter),
                trailing: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: select ? Colors.indigoAccent : Colors.white,
                    border: Border.all(
                        width: select ? 2 : 1,
                        color: select ? Colors.white30 : Colors.black),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: QuestionsCorrects().getSubjectsOfQuestionsCorrects(widget.matter),
              builder: (context, snapshot) {
                List<String>? subjectsAndLength = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print(subjectsAndLength);
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && subjectsAndLength != null) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: QuestionsCorrects.listSubjectsCorrect.length,
                    itemBuilder: (context, int index) {
                      AnimatedButtonProgress(
                          enable,
                          QuestionsCorrects.listSubjectsCorrect[index],
                          'subject'
                          //widget.daoDatabase
                          );
                    },
                  );
                }
                return SizedBox(
                  height: heightBoxNoneSubject,
                  child: Center(
                    child: Text(noneSubject),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
