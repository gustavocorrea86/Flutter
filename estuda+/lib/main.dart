import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'package:estudamais/models/models.dart';

import 'package:estudamais/screens/initial_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ModelPoints(0,0),
      ),
    ], child: const MyApp()),
  );
 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      highContrastTheme: ThemeData(
        
       applyElevationOverlayColor: true,
      ),
      title: 'Estuda +',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
       // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(70)),
          // )
        ),
        
      ),
      
      home: const ScreenInitial(),
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     // rota para pagina de entrar
      //     case '/initial':
      //       return PageTransition(
      //         type: PageTransitionType.sharedAxisHorizontal,
      //         duration: const Duration(seconds: 1),
      //         settings: settings,
      //         child: const ScreenInitial(),
      //       );
      //     // rota para pagina de carregamento das informações
      //     case '/loadingDatas':
      //       return PageTransition(
      //         type: PageTransitionType.sharedAxisHorizontal,
      //         duration: const Duration(seconds: 1),
      //         settings: settings,
      //         child: const LoadingNextPage(),
      //       );
      //     // rota para home
      //     case '/home':
      //       return PageTransition(
      //         type: PageTransitionType.sharedAxisHorizontal,
      //         duration: const Duration(seconds: 1),
      //         settings: settings,
      //         child: const HomeScreen(),
      //       );
      //       case '/discipline':
      //       return PageTransition(
      //         type: PageTransitionType.sharedAxisHorizontal,
      //         duration: const Duration(seconds: 1),
      //         settings: settings,
      //         child: const Discipline(),
      //       );
      //       case '/schoolYear':
      //       return PageTransition(
      //         type: PageTransitionType.sharedAxisHorizontal,
      //         duration: const Duration(seconds: 1),
      //         settings: settings,
      //         child: const SchoolYears(),
      //       );
      //   }
      // },
      // initialRoute: 'initial',
      // routes: {
      //   'initial': (context) => const ScreenInitial(),
      //   'loadingNextPage': (context) => const LoadingNextPage(),
      //   'home': (context) => const HomeScreen(),
      //   'accumulatedRight': (context) => const AccumulatedRight(),
      //   'accumulatedWrongs': (context) => const AccumulatedWrongs(),
      //   'schoolYear': (context) => const SchoolYears(),
      //   'subject': (context) => Subjects(),
      //   'pageQuestionsBySchoolYear': (context) =>
      //       const PageQuestionsBySchoolYear(),
      //   'discipline': (context) => const Discipline()
      // },
    );
  }
}
