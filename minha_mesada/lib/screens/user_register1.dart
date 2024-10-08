import 'package:flutter/material.dart';

class UserRegister1 extends StatefulWidget {
  UserRegister1({super.key});

  @override
  State<UserRegister1> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister1> {
  String dropDownValue = '';
  DateTime currentYears = DateTime.now();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _birthYear = TextEditingController();
  final TextEditingController _step = TextEditingController();
  List<String> schoolLevel = [
    'Ensino Fundamental 1',
    'Ensino Fundamental 2',
    'Ensino Médio'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
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
                  padding: EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: 'idade',
                      label: Text('Nome'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      label: Text('Sobrenome'),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text('Ano de nascimento'),
                          ),
                        ),
                      ),
                    ),
                    Text('Idade: 38', style: TextStyle(fontSize: 20),),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: DropdownButtonFormField(
                          decoration:
                              InputDecoration(label: Text('Nível escolar')),
                          items: schoolLevel.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String? item) {
                            setState(() {
                              dropDownValue = item!;
                            });
                          }),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Série'),
                    ),
                  ),
                ),
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
                ElevatedButton(
                    onPressed: () {
                      print(currentYears.year);
                      Navigator.pushNamed(context, 'userRegister2');
                    },
                    child: Text('Próximo'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
