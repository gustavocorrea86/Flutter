import 'package:flutter/material.dart';

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
      title: 'TaskQuiz',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.blue)),
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
        'register_questions': (context) => RegisterQuestions(),
        'pages': (context) => PagesQuestions()
      },
    );
  }
}

//projetoQuiz
//sushiemsuacasa
//VKFMJ3c9chfO9dU5
//mongodb+srv://sushiemsuacasa:VKFMJ3c9chfO9dU5@cluster0.xxwr0.mongodb.net/
