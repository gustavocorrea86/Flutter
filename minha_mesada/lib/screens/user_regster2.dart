import 'package:flutter/material.dart';

class UserRegister2 extends StatefulWidget {
  const UserRegister2({super.key});

  @override
  State<UserRegister2> createState() => _UserRegister2State();
}

class _UserRegister2State extends State<UserRegister2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastre a Senha'),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  const Color.fromARGB(255, 253, 226, 184),
                  Colors.orange,
                ])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Senha'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Confirme a senha'),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text('Cadastrar'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
