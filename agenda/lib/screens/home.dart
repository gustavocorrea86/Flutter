import 'package:agenda/datas/daoPhoneBook.dart';
import 'package:agenda/models/models_phoneBook.dart';
import 'package:agenda/widgets/boxCard.dart';
import 'package:agenda/widgets/box_edit_dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController updateName = TextEditingController();
  TextEditingController updateNumber = TextEditingController();

  Future<List<PhoneBook>>? _nameContact;

  Future<List<PhoneBook>>? dataShow() {
    if (_nameContact == null) {
      return Daophonebook().findAll();
    } else {
      return _nameContact;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda telefônica'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (nameSearch) {
                        print(nameSearch);
                        setState(
                          () {
                            if (nameSearch.isNotEmpty) {
                              _nameContact = Daophonebook().find(nameSearch);
                            } else {
                              _nameContact = null;
                            }
                          },
                        );
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        icon: Icon(Icons.person_2_outlined),
                      ),
                      controller: name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        icon: Icon(Icons.phone),
                      ),
                      controller: number,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            print(_nameContact);
                            setState(() {
                              // Daophonebook().deleteTable();
                              Daophonebook().save(
                                PhoneBook(
                                  name.text,
                                  number.text,
                                ),
                              );
                              name.clear();
                              number.clear();
                              _nameContact = null;
                            });
                            // Daophonebook().findAll();
                          },
                          child: Text('Cadastrar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Container(
              child: FutureBuilder<List<PhoneBook>>(
                future: dataShow(),
                builder: (context, snapshot) {
                  List<PhoneBook>? contacts = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        const CircularProgressIndicator(),
                        Text('Loading...')
                      ],
                    );
                  } else if (snapshot.hasData && contacts != null) {
                    if (contacts.isNotEmpty) {
                      return ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Boxcard(
                            IconButton(
                              color: const Color.fromARGB(255, 143, 15, 6),
                              onPressed: () {
                                setState(
                                  () {
                                    Daophonebook().delete(contacts[index].name);
                                  },
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                      child: BoxEditDialog(
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                Daophonebook().update(
                                                    updateName.text,
                                                    updateNumber.text,
                                                    contacts[index].name);
                                                Navigator.pop(context);
                                                updateName.clear();
                                                updateNumber.clear();
                                              });
                                            },
                                            child: Text(
                                              'Ok',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          updateName,
                                          updateNumber,
                                          contacts[index].name,
                                          contacts[index].number),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit)),
                            contacts[index].name,
                            contacts[index].number,
                          );
                        },
                      );
                    }
                    return Text(
                      'No Contacts found',
                      style: TextStyle(fontSize: 32),
                    );
                  }
                  return Text('Error to loading Cootacts');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
