import 'package:descobrindo_as_coisas/src/model/controller_accept.dart';
import 'package:descobrindo_as_coisas/src/screens/discovery_colors.dart';
import 'package:descobrindo_as_coisas/src/screens/home/home_screen.dart';
import 'package:descobrindo_as_coisas/src/screens/memory_play/screen/memory_play.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ControllerAccept(),
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Descobrindo as Coisas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'homeScreen',
      routes: {
        'homeScreen': (context) => HomeScreen(),
        'colorAndWord': (context) => DiscoveryColors(),
        'memoryPlay': (context) => MemoryPlay(),
      },
    );
  }
}
