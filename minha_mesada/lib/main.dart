import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minha_mesada/controller/controller_questions.dart';

import 'package:minha_mesada/database/dao_user_resum.dart';

import 'package:minha_mesada/models/model_right.dart';

import 'package:minha_mesada/models/models.dart';
import 'package:minha_mesada/screens/accumulated_right.dart';
import 'package:minha_mesada/screens/accumulated_wrongs.dart';

import 'package:minha_mesada/screens/filter_questions.dart';

import 'package:minha_mesada/screens/home.dart';
import 'package:minha_mesada/screens/initial_screen.dart';
import 'package:minha_mesada/screens/loading_next_page.dart';
import 'package:minha_mesada/screens/login.dart';
import 'package:minha_mesada/screens/menuDrawer/math.dart';
import 'package:minha_mesada/screens/menuDrawer/portuguese.dart';
import 'package:minha_mesada/screens/pages.dart';

import 'package:minha_mesada/screens/user_register1.dart';
import 'package:minha_mesada/service/service.dart';
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
          create: (context) => ModelNumberOfSubject(0, ['sem assunto'], ['0']))
    ], child: const MyApp()),
  );
  //Service().getFilmes();
  //Service().getRequest();
  //Service().getQuestions();
  //DaoWrong().findAllQuestionWrong();
  //DaoUserResum().findElementarySchoolAndGrade();
  //DaoUserResum().findAll();
  //DaoWrong().findMatterAsWrong();
  //DaoRight().findAllQuestionRight();
  
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
        'accumulatedWrongs': (context) => const AccumulatedWrongs(),
        'pages': (context) => const PagesQuestions(),
        'filterQuestions': (context) => const FilterQuestions(),
        'portuguese': (context) => const Portuguese(),
        'math': (context) => Math(),
      },
    );
  }
}
