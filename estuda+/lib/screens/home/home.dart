import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/home/widgets/dashbord_displice.dart';
import 'package:estudamais/widgets/show_snackBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/home/widgets/box_resum.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double shadowBox = 10;
  Service service = Service();
  //final Future _future = Service().getQuestions();
  QuestionsCorrects questionsCorrects = QuestionsCorrects();
  QuestionsIncorrects questionsIncorrects = QuestionsIncorrects();
  bool? enable;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                Service.questionsByDiscipline.clear();
                Service.resultQuestionsBySubjectsAndSchoolYear.clear();
                Service.schoolYearAndSubjects.clear();
              },
              icon: const Icon(Icons.menu),
            );
          }),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topRight,
              child: RichText(
                text: TextSpan(
                  text: 'Total de questões respondidas: ',
                  style: GoogleFonts.aboreto(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(
                      text: value.countAnswered,
                      style: GoogleFonts.aboreto(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTile(
                  leading: const Icon(Icons.list),
                  title: const Text('Disciplinas'),
                  trailing: const Icon(Icons.arrow_circle_right),
                  onTap: () {
                    Navigator.pushNamed(context, 'discipline');

                    service.getDisplice();
                  }),

              //ListTileDrawer('Ciências da Natureza', 'ciencias'),
              // const Divider(),
              // ListTileDrawer('Matemática', 'matematica'),
              // const Divider(),
              // ListTileDrawer('Língua Portuguesa', 'portugues'),
              // const Divider(),
              // ListTileDrawer('Geografia', 'geografia'),
              // const Divider(),
              // ListTileDrawer('História', 'historia'),
              // const Divider(),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  BoxResum(
                    value.pointsDb,
                    'Respostas corretas',
                    Lottie.asset('./assets/lotties/Animation_correct.json'),
                    TextButton(
                      onPressed: () {
                        if (QuestionsCorrects
                            .resultQuestionsCorrect.isNotEmpty) {
                          // CHAMA A CONSULTA PARA OBTER AS DISCIPLINAS RESPONDIDAS CORRETAMENTE
                          questionsCorrects.getDisciplineOfQuestionsCorrects();
                          Navigator.pushNamed(context, 'accumulatedRight');
                          QuestionsCorrects.subjectsOfQuestionsCorrects.clear();
                        } else {
                          showSnackBar(
                              context,
                              'Ainda não temos nenhuma questão respondida.',
                              Colors.red);
                        }
                      },
                      child: Text(
                        'Resumo',
                        style: GoogleFonts.roboto(color: Colors.yellow),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      DashbordDisplice(
                        'Ciências da Natureza',
                        Colors.green,
                        QuestionsCorrects.amountCienciasCorrects / 100,
                        QuestionsCorrects.amountCienciasCorrects.toString(),
                      ),
                      DashbordDisplice(
                        'Matemática',
                        Colors.green,
                        QuestionsCorrects.amountMatematicaCorrects / 100,
                        QuestionsCorrects.amountMatematicaCorrects.toString(),
                      ),
                      DashbordDisplice(
                        'Língua Portuguesa',
                        Colors.green,
                        QuestionsCorrects.amountPortuguesCorrects / 100,
                        QuestionsCorrects.amountPortuguesCorrects.toString(),
                      ),
                      DashbordDisplice(
                        'Geografia',
                        Colors.green,
                        QuestionsCorrects.amountGeografiaCorrects / 100,
                        QuestionsCorrects.amountGeografiaCorrects.toString(),
                      ),
                      DashbordDisplice(
                        'História',
                        Colors.green,
                        QuestionsCorrects.amountHistoriaCorrects / 100,
                        QuestionsCorrects.amountHistoriaCorrects.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: BoxResum(
                      value.errorsDb,
                      'Respostas incorretas',
                      Lottie.asset('./assets/lotties/alert.json'),
                      TextButton(
                          onPressed: () {
                            if (QuestionsIncorrects
                                .resultQuestionsIncorrect.isNotEmpty) {
                              Navigator.pushNamed(context, 'accumulatedWrongs');
                              questionsIncorrects
                                  .getDisciplineOfQuestionsIncorrects();
                              QuestionsIncorrects.subjectsOfQuestionsIncorrects
                                  .clear();
                            } else {
                              showSnackBar(
                                  context,
                                  'Ainda não temos nenhuma questão respondida.',
                                  Colors.red);
                            }
                          },
                          child: Text(
                            'Resumo',
                            style: GoogleFonts.roboto(color: Colors.yellow),
                          )),
                    ),
                  ),
                  Column(
                    children: [
                      DashbordDisplice(
                        'Ciências da Natureza',
                        Colors.red,
                        QuestionsIncorrects.amountCienciasIncorrects / 100,
                        QuestionsIncorrects.amountCienciasIncorrects.toString(),
                      ),
                      DashbordDisplice(
                        'Matemática',
                        Colors.red,
                        QuestionsIncorrects.amountMatematicaIncorrects / 100,
                        QuestionsIncorrects.amountMatematicaIncorrects
                            .toString(),
                      ),
                      DashbordDisplice(
                        'Língua Portuguesa',
                        Colors.red,
                        QuestionsIncorrects.amountPortuguesIncorrects / 100,
                        QuestionsIncorrects.amountPortuguesIncorrects
                            .toString(),
                      ),
                      DashbordDisplice(
                        'Geografia',
                        Colors.red,
                        QuestionsIncorrects.amountGeografiaIncorrects / 100,
                        QuestionsIncorrects.amountGeografiaIncorrects
                            .toString(),
                      ),
                      DashbordDisplice(
                        'História',
                        Colors.red,
                        QuestionsIncorrects.amountHistoriaIncorrects / 100,
                        QuestionsIncorrects.amountHistoriaIncorrects.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'discipline');
                          service.getDisplice();
                        },
                        child: const Text('Iniciar')),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'initial');
                    },
                    child: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

