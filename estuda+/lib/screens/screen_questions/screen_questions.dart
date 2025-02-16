import 'package:flutter/material.dart';
import 'package:estudamais/models/models.dart';

import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_alternativas.dart';
import 'package:estudamais/screens/screen_questions/widgets/box_questions.dart';

import 'package:estudamais/screens/screen_questions/widgets/box_screen_questions.dart';
import 'package:provider/provider.dart';

class PageQuestionsBySchoolYear extends StatefulWidget {
  const PageQuestionsBySchoolYear({super.key});

  @override
  State<PageQuestionsBySchoolYear> createState() =>
      _PageQuestionsBySchoolYearState();
}

class _PageQuestionsBySchoolYearState extends State<PageQuestionsBySchoolYear> {
  Service service = Service();
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    print(Service.resultQuestionsBySubjectsAndSchoolYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ModelPoints>(
        builder: (context, value, child) {
          return PageView.builder(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: Service.resultQuestionsBySubjectsAndSchoolYear.length,
            itemBuilder: (context, index) {
              return ScreenQuestions(
                  BoxQuestions(
                      Service.resultQuestionsBySubjectsAndSchoolYear[index]
                          ['question']),
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['image'],
                  BoxAlternatives(
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['alternativeA'],
                    'A',
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['answer'],
                    value.isAnswered,
                    index,
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                        .toString(),
                  ),
                  BoxAlternatives(
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['alternativeB'],
                    'B',
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['answer'],
                    value.isAnswered,
                    index,
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                        .toString(),
                  ),
                  BoxAlternatives(
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['alternativeC'],
                    'C',
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['answer'],
                    value.isAnswered,
                    index,
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                        .toString(),
                  ),
                  BoxAlternatives(
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['alternativeD'],
                    'D',
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]
                        ['answer'],
                    value.isAnswered,
                    index,
                    Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                        .toString(),
                  ),
                  controller,
                  Service.resultQuestionsBySubjectsAndSchoolYear.length
                      .toString(),
                  index,
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['displice'],
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['subject'],
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]['id']
                      .toString(),
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['elementarySchool'],
                  Service.resultQuestionsBySubjectsAndSchoolYear[index]
                      ['schoolYear']);
            },
          );
        },
      ),
    );
  }
}
