import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        backgroundColor: const Color.fromARGB(255, 131, 98, 0),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 247, 204, 140),
              Colors.orange,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: 150,
            //   height: 150,
            //   child: 
            //   // Lottie.asset('/minha_mesada/assets/images/Animation - 1728300067190.json')
              
            //   Lottie.network(
            //       'https://lottie.host/bd4ba235-1f26-4498-a2f7-1616fb24635b/GXIiq9SuaY.json',
            //       fit: BoxFit.cover),
            // ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          label: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
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
                      },
                      child: Text('Entrar'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
