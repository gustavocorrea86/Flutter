import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/screens/accumulated_corrects/accumulated_right.dart';
import 'package:estudamais/screens/accumulated_incorrects/accumulated_wrongs.dart';
import 'package:estudamais/screens/discipline/discipline.dart';
import 'package:estudamais/screens/initial_screen.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/screens/home/widgets/dashbord_displice.dart';
import 'package:estudamais/widgets/background.dart';
import 'package:estudamais/widgets/button_next.dart';
import 'package:estudamais/widgets/listTile_drawer.dart';
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
  QuestionsCorrects questionsCorrects = QuestionsCorrects();
  QuestionsIncorrects questionsIncorrects = QuestionsIncorrects();
  //DaoUserResum dataBase = DaoUserResum();
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
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
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
                      text: DaoUserResum.listId.length.toString(),
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
          backgroundColor: const Color.fromARGB(255, 209, 209, 209),
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTileDrawer(
                contextText: 'Responder questões',
                onTap: () {
                  // chama a função para mostrar as disciplinas
                  service.getDisplice();
                  //chama a rota para selecionar as disciplinas
                  Routes().pushRoute(context, const Discipline());
                  // limpa a lista do resultado da consulta

                  // fechao container onde mostra questão ja respondida
                  value.actBoxAnswered(0);
                },
                icon: const Icon(Icons.auto_stories_rounded),
              ),
              ListTileDrawer(
                contextText: 'Resumo Corretas',
                onTap: () {},
                icon: const Icon(Icons.list),
              ),
              ListTileDrawer(
                contextText: 'Resumo Incorretas',
                onTap: () {},
                icon: const Icon(Icons.list),
              ),
              ListTileDrawer(
                contextText: 'Sobre',
                onTap: () {},
                icon: const Icon(Icons.help),
              ),
              ListTileDrawer(
                contextText: 'Excluir respostas',
                onTap: () {},
                icon: const Icon(Icons.delete),
              ),
              ListTileDrawer(
                contextText: 'Sair',
                onTap: () {},
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Background(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    BoxResum(
                      DaoUserResum.listIdCorrects.length.toString(),
                      'Corretas',
                      Lottie.asset('./assets/lotties/Animation_correct.json'),
                      TextButton(
                        onPressed: () {
                          if (QuestionsCorrects
                              .resultQuestionsCorrect.isNotEmpty) {
                            // CHAMA A CONSULTA PARA OBTER AS DISCIPLINAS RESPONDIDAS CORRETAMENTE
                            questionsCorrects
                                .getDisciplineOfQuestionsCorrects();

                            // chama a pagina onde mostra as questões respondidas corretamente
                            Routes()
                                .pushRoute(context, const AccumulatedRight());
                            // limpa a List das questões por assunto que foram consultadas
                            QuestionsCorrects.mapYearAndSubjectSelected.clear();
                            // limpa a list do resultado das questões consultadas
                            QuestionsCorrects.resultQuestions.clear();
                            // limpa a lista que serve comoauxiliar para excluir duplicatas
                            QuestionsCorrects.listAuxYearAndSubjectSelected
                                .clear();
                            //value.showSubjects(false);
                          } else {
                            showSnackBar(
                                context,
                                'Ainda não temos nenhuma questão respondida.',
                                Colors.red);
                          }
                        },
                        child: Text(
                          'Resumo',
                          style: GoogleFonts.roboto(color: Colors.amber),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        DashbordDisplice(
                          'Ciências',
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
                        DaoUserResum.listIdIncorrects.length.toString(),
                        'Incorretas',
                        Lottie.asset('./assets/lotties/alert.json'),
                        TextButton(
                            onPressed: () {
                              if (QuestionsIncorrects
                                  .resultQuestionsIncorrect.isNotEmpty) {
                                value.answered(false);
                                Routes().pushRoute(
                                    context, const AccumulatedWrongs());
                                questionsIncorrects
                                    .getDisciplineOfQuestionsIncorrects();

                                QuestionsIncorrects.mapYearAndSubjectSelected
                                    .clear();
                                QuestionsIncorrects
                                    .listAuxYearAndSubjectSelected
                                    .clear();
                                QuestionsIncorrects.resultQuestions.clear();
                                //value.showSubjects(false);
                              } else {
                                showSnackBar(
                                    context,
                                    'Ainda não temos nenhuma questão respondida.',
                                    Colors.red);
                              }
                            },
                            child: Text(
                              'Resumo',
                              style: GoogleFonts.roboto(color: Colors.amber),
                            )),
                      ),
                    ),
                    Column(
                      children: [
                        DashbordDisplice(
                          'Ciências',
                          Colors.red,
                          QuestionsIncorrects.amountCienciasIncorrects / 100,
                          QuestionsIncorrects.amountCienciasIncorrects
                              .toString(),
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
                          QuestionsIncorrects.amountHistoriaIncorrects
                              .toString(),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Routes().pushRoute(context, const ScreenInitial());
                      },
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
            onTap: () {
              Routes().pushRoute(context, const Discipline());
              //service.getDisplice();
              Service.resultQuestionsBySubjectsAndSchoolYear.clear();
              value.actBoxAnswered(0);
            },
            child: const ButtonNext(
              textContent: 'Iniciar',
            )),
      );
    });
  }
}
