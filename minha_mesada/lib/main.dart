import 'package:flutter/material.dart';
import 'package:mongodb_api/screens/elementary_school.dart';
import 'package:mongodb_api/screens/elementary_school_1.dart';
import 'package:mongodb_api/screens/elementary_school_2.dart';

import 'package:mongodb_api/screens/home.dart';
import 'package:mongodb_api/screens/pages.dart';
import 'package:mongodb_api/screens/register_questions.dart';

void main() {
  runApp(const MyApp());
  // DaoQuiz().findAll();
  // DaoQuizUser().findAllUser();
  // DaoQuizUser().findPoints('Pedro');
  // DaoQuiz().findAlternatives();
  // DaoQuiz().findNumberQuestion();
  // DaoQuiz().findQuestions();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizMesada',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomeScreen(),
        'register_questions': (context) => RegisterQuestions(),
        'pages': (context) => const PagesQuestions(),
        'elementary_school': (context) => const ElementarySchool(),
        'elementary_school_1': (context) => const ElementarySchool1(),
        'elementary_school_2': (context) => const ElementarySchool2()
      },
    );
  }
}

//projetoQuiz
//sushiemsuacasa
//VKFMJ3c9chfO9dU5
//mongodb+srv://sushiemsuacasa:VKFMJ3c9chfO9dU5@cluster0.xxwr0.mongodb.net/
