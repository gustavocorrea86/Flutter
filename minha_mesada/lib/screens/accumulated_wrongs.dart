import 'package:flutter/material.dart';
import 'package:minha_mesada/database/dao_wrong.dart';
import 'package:minha_mesada/widgets/list_matter_subjects.dart';

class AccumulatedWrongs extends StatefulWidget {
  const AccumulatedWrongs({super.key});

  @override
  State<AccumulatedWrongs> createState() => _AccumulatedWrongsState();
}

class _AccumulatedWrongsState extends State<AccumulatedWrongs> {
  final Future _future = DaoWrong().findMatterAsWrong();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erros acumulados'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('./assets/images/ball-7280265_640.jpg'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: const Color.fromARGB(188, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: FutureBuilder(
                          future: _future,
                          builder: (context, snapshot) {
                            List<Map<String, dynamic>>? displice =
                                snapshot.data;
                            print('displice = $displice');

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasData && displice != null) {
                              if (displice.isNotEmpty) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: displice.length,
                                  itemBuilder: (context, int index) {
                                    return ListMatterAndSubjects(
                                        displice[index]['materia'],
                                        DaoWrong(),
                                        DaoWrong.subjects,
                                        DaoWrong.lengthSubject,
                                        DaoWrong.listOfWrongSubjects);
                                  },
                                );
                              }
                            }
                            return const Center(
                              child: Text('Nenhuma questão respondida '),
                            );
                          }),
                    )),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
