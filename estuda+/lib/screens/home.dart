import 'package:estudamais/widgets/box_button_animated.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:estudamais/controller/counter_errors.dart';
import 'package:estudamais/controller/counter_points.dart';
import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/database/dao_wrong.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ensino Fundamental 1 - 5ª série',
            style: GoogleFonts.aboreto(
              fontSize: 15,
              color: Colors.white,
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 4.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Header'),
              ),
              ListTileDrawer('Ciências Naturais', 'ciencias'),
              Divider(),
              ListTileDrawer('Matemática', 'matematica'),
              Divider(),
              ListTileDrawer('Língua Portuguesa', 'portugues'),
              Divider(),
              ListTileDrawer('Geografia', 'geografia'),
              Divider(),
              ListTileDrawer('História', 'historia'),
              Divider(),
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
                    Padding(
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                    BoxResum(
                      value.pointsDb,
                      'Acertos Acumulados',
                      Lottie.asset('./assets/lotties/coins3.json'),
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
                    BoxResum(
                      'R\$ ${value.pointsDb},00',
                      'Mesada do Mês',
                      Lottie.asset('./assets/lotties/cash2_animated.json'),
                      TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, 'accumulatedMonth');
                          },
                          child: Text(
                            'Detalhes',
                            style: GoogleFonts.roboto(color: Colors.white),
                          )),
                    ),
                    BoxResum(
                      value.pointsDb,
                      'Acertos do Mês',
                      Lottie.asset('./assets/lotties/coins2_animated.json'),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Detalhes',
                            style: GoogleFonts.roboto(color: Colors.white),
                          )),
                    ),
                    BoxResum(
                      value.errorsDb,
                      'Erros Acumulados',
                      Lottie.asset('./assets/lotties/coins_grey_animated.json'),
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
                    BoxResum(
                      value.errorsDb,
                      'Erros do Mês',
                      Lottie.asset('./assets/lotties/alert.json'),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Detalhes',
                            style: GoogleFonts.roboto(color: Colors.yellow),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTapUp: (_) {
                            setState(() {
                              shadowBox = 10;
                            });
                            value.pointsHits('0');
                            value.answered(false);
                            value.actBoxAnswered(0);
                            CounterPoints.points = 0;
                            CounterErrors.errors = 0;
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              Navigator.pushNamed(context, 'pages');
                            });
                          },
                          onTapDown: (_) {
                            setState(() {
                              shadowBox = 4;
                            });
                          },
                          child: BoxButton('Iniciar', shadowBox, 88, 80, 15, Colors.black87)),
                    ),
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
