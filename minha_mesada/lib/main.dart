import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:minha_mesada/database/dao_user_resum.dart';
import 'package:minha_mesada/models/model_right.dart';

import 'package:minha_mesada/models/models.dart';
import 'package:minha_mesada/screens/accumulated_right.dart';
import 'package:minha_mesada/screens/accumulated_wrongs.dart';

import 'package:minha_mesada/screens/elementary_school.dart';
import 'package:minha_mesada/screens/elementary_school_1.dart';
import 'package:minha_mesada/screens/elementary_school_2.dart';

import 'package:minha_mesada/screens/home.dart';
import 'package:minha_mesada/screens/initial_screen.dart';
import 'package:minha_mesada/screens/loading_next_page.dart';
import 'package:minha_mesada/screens/login.dart';
import 'package:minha_mesada/screens/pages.dart';

import 'package:minha_mesada/screens/user_register1.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ModelPoints('0', '0', DaoUserResum.totalPoints,
            DaoUserResum.totalErrors, DaoUserResum.answeredQuestions),
      ),
      ChangeNotifierProvider(
        create: (context) => ModelLengthQuestions(
            lengthQuestions: 0, subject: 'Sem assunto', addSubject: []),
      ),
      ChangeNotifierProvider(
          create: (context) => ModelNumberOfSubject(0, ['sem assunto'], ['0']))
    ], child: const MyApp()),
  );
  //Service().getRequest();
  //DaoWrong().findAllQuestionWrong();
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
        'accumulatedWrongs': (context) => const AccumulatedWrongs(),
        'pages': (context) => const PagesQuestions(),
        'elementary_school': (context) => const ElementarySchool(),
        'elementary_school_1': (context) => const ElementarySchool1(),
        'elementary_school_2': (context) => const ElementarySchool2()
      },
    );
  }
}
