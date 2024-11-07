import 'package:flutter/material.dart';

import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/model_right.dart';

import 'package:mongodb_api/models/models.dart';
import 'package:mongodb_api/screens/accumulated_month.dart';
import 'package:mongodb_api/screens/accumulated_right.dart';

import 'package:mongodb_api/screens/elementary_school.dart';
import 'package:mongodb_api/screens/elementary_school_1.dart';
import 'package:mongodb_api/screens/elementary_school_2.dart';

import 'package:mongodb_api/screens/home.dart';
import 'package:mongodb_api/screens/initial_screen.dart';
import 'package:mongodb_api/screens/loading_next_page.dart';
import 'package:mongodb_api/screens/login.dart';
import 'package:mongodb_api/screens/pages.dart';

import 'package:mongodb_api/screens/user_register1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ModelPoints('0', '0', DaoUserResum.totalPoints,
            DaoUserResum.totalErrors, DaoUserResum.answeredQuestions),
      ),
      ChangeNotifierProvider(
          create: (context) => ModelLengthQuestions(
              lengthQuestions: 0, subject: 'Sem assunto', addSubject: [])),
    ], child: const MyApp()),
  );
  //DaoRight().findForMateria('Matémática');

  //DaoUserResum().findAll();

  //DaoRight().findAllQuestionRight();
  // DaoWrong().findAllQuestionWrong();
  // DaoRight().findAssuntoAsRight();
  //DaoRight().findSubjectAsRight();
  // DaoRight().findForSubject('Multiplicação');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizMesada',
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
        'accumulatedMonth': (context) => Test(),
        'pages': (context) => const PagesQuestions(),
        'elementary_school': (context) => const ElementarySchool(),
        'elementary_school_1': (context) => const ElementarySchool1(),
        'elementary_school_2': (context) => const ElementarySchool2()
      },
    );
  }
}
