import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mongodb_api/database/dao_user_resum.dart';
import 'package:mongodb_api/models/models.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          backgroundColor: const Color.fromARGB(255, 131, 98, 0),
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 204, 140),
                    Colors.orange,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      height: 300,
                      child: Lottie.asset(
                          './assets/lotties/animation_login.json')),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                                label: Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              label: Text(
                                'Senha',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'home');
                            // DaoUserResum().findPoints();

                            value.showPoints(DaoUserResum.totalPoints);
                            value.showErrors(DaoUserResum.totalErrors);
                            value.counterOfAnswereds(
                                DaoUserResum.answeredQuestions);
                          },
                          child: const Text('Entrar'),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'userRegister');
                            },
                            child: const Text('Cadastre-se'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
