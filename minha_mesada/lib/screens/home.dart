import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:mongodb_api/widgets/box_resum.dart';
import 'package:mongodb_api/widgets/screen_questions.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   DaoUserResum().findPoints();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Minha Mesada'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.countAnswered,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Header'),
                ),
                ListTile(
                  leading: const Icon(Icons.manage_history),
                  title: const Text('Matemática'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.pushNamed(context, 'elementary_school');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.manage_history),
                  title: const Text('Português'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                    fit: BoxFit.cover),
              ),
              Column(
                children: [
                  BoxResum(
                    value.pointsDb,
                    'Total de Acertos ',
                    Lottie.asset('./assets/lotties/coins3.json'),
                  ),
                  BoxResum(
                    '0',
                    'Mesada do Mês',
                    Lottie.asset('./assets/lotties/cash2_animated.json'),
                  ),
                  BoxResum(
                    '0',
                    'Acertos do Mês',
                    Lottie.asset('./assets/lotties/coins2_animated.json'),
                  ),
                  BoxResum(
                    value.errorsDb,
                    'Total de Erros',
                    Lottie.asset('./assets/lotties/coins_grey_animated.json'),
                  ),
                  BoxResum(
                    value.errorsDb,
                    'Erros do Mês',
                    Lottie.asset('./assets/lotties/coins_grey_animated.json'),
                  ),
                ],
              )
            ],
          ),
          floatingActionButton: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'pages');
                  value.pointsHits('0');
                  DaoUserResum().findPoints();
                  DaoUserResum().findErrors();
                  DaoUserResum().findAnswereds();
                  value.answered(false);
                  value.actBoxAnswered(0);
                  value.showPoints(DaoUserResum.totalPoints);
                  value.showErrors(DaoUserResum.totalErrors);
                  Counter.countPoints = 0;
                  Counter.countErrors = 0;
                  DaoUserResum().findAll();
                },
                child: const Text('Pages'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'initial');
                },
                child: const Text('Tela inicial'),
              ),
              ElevatedButton(
                  onPressed: () {
                    DaoUserResum().delete();
                  },
                  child: const Text('Deletar pontos'))
            ],
          ));
    });
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