//  ESSA É A TELA INICIAL ONDE O USUARIO SE CADASTRA OU CHAMA A TELA PARA FAZER O LOGIN.
import 'package:estudamais/models/models_user_resum.dart';
import 'package:estudamais/screens/loading_next_page.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenInitial extends StatefulWidget {
  const ScreenInitial({super.key});

  @override
  State<ScreenInitial> createState() => _ScreenInitialState();
}

class _ScreenInitialState extends State<ScreenInitial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./assets/images/cubs.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  if (DaoUserResum.table.isEmpty) {
                    DaoUserResum().insertUser(
                      const ModelsUserResum(
                        totalPoints: '0',
                        totalOfQuestions: '0',
                        totalError: '0',
                        idQuestions: '0',
                        idQuestionCorrect: '0',
                        idQuestionIncorrect: '0',
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoadingNextPage(
                            msgPrimary: 'Aguardando informações',
                            msgSecundary: 'Carregando questões',
                          );
                        },
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoadingNextPage(
                            msgPrimary: 'Aguardando informações',
                            msgSecundary: 'Carregando questões',
                          );
                        },
                      ),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Center(
                    child: Text(
                      'Entrar',
                      style: GoogleFonts.aboreto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: GestureDetector(
            //     onTap: () {
            //       //  Chama a tela login.dart onde o usuário insere os dados para logar
            //       Navigator.pushNamed(context, 'userRegister');
            //     },
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       height: 80,
            //       decoration: BoxDecoration(
            //           color: Colors.amber,
            //           borderRadius: BorderRadius.circular(20),
            //           boxShadow: const [
            //             BoxShadow(
            //               color: Colors.black54,
            //               blurRadius: 2,
            //               spreadRadius: 1,
            //             )
            //           ]),
            //       child: const Center(
            //         child: Text('Cadastrar'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                // DaoWrong().deleteTableWrong();
                // DaoRight().deleteTableRight();
                DaoUserResum().delete();
              },
              child: const Text('Reset Database (teste)'),
            ),
            TextButton(
              onPressed: () {
                DaoUserResum().close();
              },
              child: const Text('Close Database (teste)'),
            ),
          ],
        ),
      ),
    );
  }
}
