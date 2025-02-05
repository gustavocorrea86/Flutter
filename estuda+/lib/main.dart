import 'dart:typed_data';

import 'package:estudamais/models/models_user_resum.dart';
import 'package:estudamais/screens/discipline.dart';
import 'package:estudamais/screens/page_questions_by_schoolyear.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:estudamais/database/dao_user_resum.dart';

import 'package:estudamais/models/model_right.dart';

import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/accumulated_right.dart';
import 'package:estudamais/screens/accumulated_wrongs.dart';

import 'package:estudamais/screens/home.dart';
import 'package:estudamais/screens/initial_screen.dart';
import 'package:estudamais/screens/loading_next_page.dart';
import 'package:estudamais/screens/login.dart';

import 'package:estudamais/screens/pages.dart';
import 'package:estudamais/screens/school_years.dart';
import 'package:estudamais/screens/subjects.dart';

import 'package:estudamais/screens/user_register1.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ModelPoints(
            '0',
            '0',
            DaoUserResum.totalPoints,
            DaoUserResum.totalErrors,
            DaoUserResum.answeredQuestions,
            0,
            'Displice?',
            'SchoolYear?',
            'getDisplice',
            'getSchoolYear',
            'erroSubjetc',
            false,
            false),
      ),
      ChangeNotifierProvider(
          create: (context) => ModelNumberOfSubject(0, ['sem assunto'], ['0']))
    ], child: const MyApp()),
  );
  DaoUserResum().findIdQuestionsCorrect();

  Future.delayed(Duration(seconds: 2)).then((value) {
    QuestionsCorrects().getQuestionsCorrects();
  });

  // Future.delayed(Duration(seconds: 4)).then((value) {
  //    QuestionsCorrects().getDisciplineOfQuestionsCorrects();
  // });

  //QuestionsCorrects().getDisciplineOfQuestionsCorrects();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study and Cash',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.indigo[300])),
      initialRoute: 'initial',
      routes: {
        'initial': (context) => const ScreenInitial(),
        'login': (context) => const Login(),
        'loadingNextPage': (context) => const LoadingNextPage(),
        'userRegister': (context) => const UserRegister1(),
        'home': (context) => const HomeScreen(),
        'accumulatedRight': (context) => const AccumulatedRight(),
        // 'accumulatedWrongs': (context) => const AccumulatedWrongs(),
        //'pages': (context) => const PagesQuestions(),
        'schoolYear': (context) => const SchoolYears(),
        'subject': (context) => Subjects(),
        'pageQuestionsBySchoolYear': (context) =>
            const PageQuestionsBySchoolYear(),
        'discipline': (context) => const Discipline()
      },
    );
  }
}
