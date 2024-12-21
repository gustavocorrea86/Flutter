import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_ritgh.dart';
import 'package:estudamais/models/model_right.dart';
import 'package:estudamais/widgets/list_matter_subjects.dart';
import 'package:provider/provider.dart';

class AccumulatedRight extends StatefulWidget {
  const AccumulatedRight({super.key});

  @override
  State<AccumulatedRight> createState() => _AccumulatedRightState();
}

class _AccumulatedRightState extends State<AccumulatedRight> {
  bool checked = false;
  //DaoRight databaseRight = DaoRight();

  //String msgNoneDisplice = '';
  final Future _future = DaoRight().findMatterAsRight();
  onChecked() {
    setState(() {
      checked = !checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelNumberOfSubject>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acertos acumulados'),
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
              //alignment: Alignment.center,
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
                          List<Map<String, dynamic>>? displice = snapshot.data;
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
                                      displice[index]['displice'],
                                      DaoRight(),
                                      DaoRight.subjects,
                                      DaoRight.lengthSubject,
                                      DaoRight.listOfRightSubject);
                                },
                              );
                            }
                          }
                          return const Center(
                            child: Text('Nenhuma questão respondida'),
                          );
                        },
                      ),
                    ),
                  ),
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
    });
  }
}
