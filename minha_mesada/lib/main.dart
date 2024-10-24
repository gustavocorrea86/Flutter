import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';

import 'package:mongodb_api/models/models.dart';

import 'package:mongodb_api/screens/elementary_school.dart';
import 'package:mongodb_api/screens/elementary_school_1.dart';
import 'package:mongodb_api/screens/elementary_school_2.dart';

import 'package:mongodb_api/screens/home.dart';
import 'package:mongodb_api/screens/initial_screen.dart';
import 'package:mongodb_api/screens/login.dart';
import 'package:mongodb_api/screens/pages.dart';

import 'package:mongodb_api/screens/user_register1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ModelPoints('0', '0', DaoUserResum.totalPoints),
      )
    ], child: const MyApp()),
  );
  // DaoUserResum().insertPoints('6');
  // DaoUserResum().updatePoints('10','4');
  // DaoUserResum().findPoints();
  // DaoUserResum().delete();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizMesada',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: AppBarTheme(backgroundColor: Colors.indigo[300])),
      initialRoute: 'initial',
      routes: {
        'initial': (context) => const ScreenInitial(),
        'login': (context) => const Login(),
        'userRegister': (context) => UserRegister1(),
        'home': (context) => const HomeScreen(),
        'pages': (context) => const PagesQuestions(),
        'elementary_school': (context) => const ElementarySchool(),
        'elementary_school_1': (context) => const ElementarySchool1(),
        'elementary_school_2': (context) => const ElementarySchool2()
      },
    );
  }
}
