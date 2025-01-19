//  ESSA É A TELA INICIAL ONDE O USUARIO SE CADASTRA OU CHAMA A TELA PARA FAZER O LOGIN.
import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/database/dao_wrong.dart';

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
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //print(Service.result[1]);
                  Navigator.pushNamed(context, 'login');
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
                  child: const Center(
                    child: Text('Login'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  //  Chama a tela login.dart onde o usuário insere os dados para logar
                  Navigator.pushNamed(context, 'userRegister');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ]),
                  child: const Center(
                    child: Text('Cadastrar'),
                  ),
                ),
              ),
            ),
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
                DaoWrong().deleteTableWrong();
                DaoRight().deleteTableRight();
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
