import 'package:estudamais/database/dao_wrong.dart';
import 'package:estudamais/service/service.dart';
import 'package:estudamais/widgets/animated_button_circle.dart';
import 'package:estudamais/widgets/dashbord_displice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/controller/counter_errors.dart';
import 'package:estudamais/controller/counter_points.dart';
import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/box_resum.dart';
import 'package:estudamais/widgets/listTile_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double shadowBox = 10;
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
                Service.questionsByDiscipline.clear();
                Service.resultQuestionsBySubjectsAndSchoolYear.clear();
                Service.schoolYearAndSubjects.clear();
                //value.displiceURL = '';
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
              ListTileDrawer('Ciências da Natureza', 'ciencias'),
              const Divider(),
              ListTileDrawer('Matemática', 'matematica'),
              const Divider(),
              ListTileDrawer('Língua Portuguesa', 'portugues'),
              const Divider(),
              ListTileDrawer('Geografia', 'geografia'),
              const Divider(),
              ListTileDrawer('História', 'historia'),
              const Divider(),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                  fit: BoxFit.cover),
            ),
            Container(
              // margin: EdgeInsets.all(8),
              // color: Colors.white24,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    BoxResum(
                      value.pointsDb,
                      'Acertos Totais',
                      Lottie.asset('./assets/lotties/Animation_correct.json'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'accumulatedRight');
                          DaoRight.listQuestionsRight.clear();
                        },
                        child: Text(
                          'Detalhes',
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        DashbordDisplice(
                            'Ciências da Natureza', Colors.green, 0.10, 10),
                        DashbordDisplice('Matemática', Colors.green, 0.50, 233),
                        DashbordDisplice(
                            'Língua Portuguesa', Colors.green, 0.100, 44),
                        DashbordDisplice('Geografia', Colors.green, 0.30, 5030),
                        DashbordDisplice('História', Colors.green, 0.40, 90),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: BoxResum(
                        value.errorsDb,
                        'Erros Totais',
                        Lottie.asset('./assets/lotties/alert.json'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'accumulatedWrongs');
                              DaoWrong.listQuestionsWrongs.clear();
                            },
                            child: Text(
                              'Detalhes',
                              style: GoogleFonts.roboto(color: Colors.yellow),
                            )),
                      ),
                    ),
                    const Column(
                      children: [
                        DashbordDisplice(
                            'Ciências da Natureza', Colors.red, 0.005, 122),
                        DashbordDisplice('Matemática', Colors.red, 0.010, 600),
                        DashbordDisplice(
                            'Língua Portuguesa', Colors.red, 0.20, 12),
                        DashbordDisplice('Geografia', Colors.red, 0.300, 999),
                        DashbordDisplice('História', Colors.red, 0.40, 2),
                      ],
                    ),
                    AnimatedButtonCircle('Iniciar', 88, 80, 15, () {
                      value.pointsHits('0');
                      value.answered(false);
                      value.actBoxAnswered(0);
                      CounterPoints.points = 0;
                      CounterErrors.errors = 0;
                      Future.delayed(const Duration(seconds: 1)).then((value) {
                        Navigator.pushNamed(context, 'pages');
                      });
                    }),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'initial');
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// BoxResum(
                    //   'R\$ ${value.pointsDb},00',
                    //   'Mesada do Mês',
                    //   Lottie.asset('./assets/lotties/cash2_animated.json'),
                    //   TextButton(
                    //       onPressed: () {
                    //         // Navigator.pushNamed(context, 'accumulatedMonth');
                    //       },
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       )),
                    // ),
                    // BoxResum(
                    //   value.pointsDb,
                    //   'Acertos do Mês',
                    //   Lottie.asset('./assets/lotties/Animation _Allwrongs.json'),
                    //   TextButton(
                    //       onPressed: () {},
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.white),
                    //       )),
                    // ),
                    // BoxResum(
                    //   value.errorsDb,
                    //   'Erros Acumulados',
                    //   Lottie.asset('./assets/lotties/Animation _Allwrongs.json'),
                    //   TextButton(
                    //       onPressed: () {
                    //         Navigator.pushNamed(context, 'accumulatedWrongs');
                    //         DaoWrong.listQuestionsWrongs.clear();
                    //       },
                    //       child: Text(
                    //         'Detalhes',
                    //         style: GoogleFonts.roboto(color: Colors.yellow),
                    //       )),
                    // ),
