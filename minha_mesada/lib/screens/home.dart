import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                onTap: () {
                  Navigator.pushNamed(context, 'elementary_school');
                },
              ),
              ListTile(
                leading: Icon(Icons.manage_history),
                title: Text('Português'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Container(
                  width: 120,
                  height: 120,
                  child: Column(
                    children: [
                      Text('Pontos'),
                      Card(child: Consumer<ModelPoints>(
                          builder: (context, value, child) {
                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            value.hits,
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          )),
                        );
                      }))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Row(
          children: [
            Consumer<ModelPoints>(
              builder: (_, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'pages');
                    value.pointsHits('0');
                    DaoUserResum().insertPoints('0');
                  },
                  child: Text('Pages'),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'initial');
                },
                child: Text('Tela inicial'),),
                ElevatedButton(
                onPressed: () {
                   DaoUserResum().delete();
                },
                child: Text('Deletar pontos'))
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