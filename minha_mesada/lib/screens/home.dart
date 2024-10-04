import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_quizMath.dart';
import 'package:mongodb_api/widgets/box_alternativas.dart';
import 'package:mongodb_api/widgets/box_questions.dart';
import 'package:mongodb_api/widgets/screen_questions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final Future _future = DaoQuiz().findQuestions();
  // final Color green = Colors.green;
  // final Color red = Colors.red;
  // Future resultsList = DaoQuiz().findAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TasQuiz'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Header'),
                decoration: BoxDecoration(color: Colors.blue),
              ),
              ListTile(
                leading: Icon(Icons.manage_history),
                title: Text('Matemática'),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){
                  Navigator.pushNamed(context,'elementary_school');
                },
              ),
              ListTile(
                leading: Icon(Icons.manage_history),
                title: Text('Português'),
                trailing: Icon(Icons.arrow_forward),
                onTap: (){},
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('./assets/images/ball-7280265_640.jpg'),
                  fit: BoxFit.cover)),
        ),
        floatingActionButton: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'register_questions');
              },
              child: Text('Cadastrar\nperguntas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'pages');
                // print(resultsList);
              },
              child: Text('Pages'),
            ),
          ],
        ));
  }
}

// Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             child: FutureBuilder(
//               future: _future,
//               builder: (context, snapshot) {
//                 List? perguntas = snapshot.data;
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(),
//                         Text('Carregando...')
//                       ],
//                     ),
//                   );
//                 } else if (snapshot.hasData && perguntas != null) {
//                   return ListView.builder(
//                     itemCount: perguntas.length,
//                     itemBuilder: (context, index) {
//                       // print(perguntas[2]);

//                       return Text(perguntas[index]);
//                     },
//                   );
//                 }
//                 return Center(child: Text('Nenhuma pergunta cadastrada'));
//               },
//             ),
//           ),