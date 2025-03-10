import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapSelectedDisciplines extends StatefulWidget {
  final List listMap;
  final Color? textColor;
  final Axis direction;

  const MapSelectedDisciplines(
      {required this.listMap,
      this.textColor = Colors.white,
      required this.direction,
      super.key});

  @override
  State<MapSelectedDisciplines> createState() => _MapSelectedDisciplinesState();
}

class _MapSelectedDisciplinesState extends State<MapSelectedDisciplines> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: widget.direction,
              itemCount: widget.listMap.length,
              itemBuilder: (context, int index) {
                return Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        ' ${widget.listMap[index]['subjects']} -',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.textColor,
                            fontSize: 16),
                      ),
                    ),
                    Text(
                      '${widget.listMap[index]['schoolYear']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // if (QuestionsCorrects
                              //         .mapYearAndSubjectSelected.isEmpty ||
                              //     QuestionsIncorrects
                              //         .mapYearAndSubjectSelected.isEmpty) {
                              //   value.showSubjects(false);
                              // }
                              if (QuestionsCorrects
                                      .listAuxYearAndSubjectSelected
                                      .isNotEmpty &&
                                  QuestionsCorrects
                                      .mapYearAndSubjectSelected.isNotEmpty) {
                                QuestionsCorrects.listAuxYearAndSubjectSelected
                                    .removeWhere(
                                  (el) =>
                                      el['subjects'] ==
                                          widget.listMap[index]['subjects'] &&
                                      el['schoolYear'] ==
                                          widget.listMap[index]['schoolYear'],
                                );
                                QuestionsCorrects.mapYearAndSubjectSelected
                                    .removeWhere(
                                  (el) =>
                                      el['subjects'] ==
                                          widget.listMap[index]['subjects'] &&
                                      el['schoolYear'] ==
                                          widget.listMap[index]['schoolYear'],
                                );
                              }

                              if (QuestionsIncorrects
                                      .mapYearAndSubjectSelected.isNotEmpty &&
                                  QuestionsIncorrects
                                      .listAuxYearAndSubjectSelected
                                      .isNotEmpty) {
                                QuestionsIncorrects
                                    .listAuxYearAndSubjectSelected
                                    .removeWhere(
                                  (el) =>
                                      el['subjects'] ==
                                          widget.listMap[index]['subjects'] &&
                                      el['schoolYear'] ==
                                          widget.listMap[index]['schoolYear'],
                                );
                                QuestionsIncorrects.mapYearAndSubjectSelected
                                    .removeWhere(
                                  (el) =>
                                      el['subjects'] ==
                                          widget.listMap[index]['subjects'] &&
                                      el['schoolYear'] ==
                                          widget.listMap[index]['schoolYear'],
                                );
                              }
                            });
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 19,
                          )),
                    )
                  ],
                );
              }),
        ),
      );
    });
  }
}
