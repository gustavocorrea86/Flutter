import 'dart:async';

import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';
import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/loading.dart';
import 'package:provider/provider.dart';

class LoadingNextPage extends StatefulWidget {
  final String? msgPrimary;
  final String? msgSecundary;
  const LoadingNextPage({
    this.msgPrimary = 'Atualizando informações',
    this.msgSecundary = 'Atualizado!',
    super.key,
  });

  @override
  State<LoadingNextPage> createState() => _LoadingNextPageState();
}

class _LoadingNextPageState extends State<LoadingNextPage> {
  QuestionsCorrects questionsCorrects = QuestionsCorrects();
  QuestionsIncorrects questionsIncorrects = QuestionsIncorrects();
  Service service = Service();

  @override
  void initState() {
    DaoUserResum()
        .findAnswered(); // faz busca do total de perguntas respondidas
    super.initState();
  }

  nextPage() {
    Provider.of<ModelPoints>(context, listen: false)
        .showPoints(DaoUserResum.totalPoints);
    Provider.of<ModelPoints>(context, listen: false)
        .showErrors(DaoUserResum.totalErrors);
    Provider.of<ModelPoints>(context, listen: false)
        .counterOfAnswereds(DaoUserResum.answeredQuestions);
    QuestionsCorrects().counterDisciplineCorrects();
    QuestionsIncorrects().counterDisciplineIncorrects();
    Navigator.pushNamed(context, 'home');
  }

  Stream getDatas() async* {
    //await Future.delayed(Duration(seconds: 5));
    yield await service.getQuestions(); // busca todas as questões
    //await Future.delayed(Duration(seconds: 1));
    yield await questionsCorrects.getQuestionsCorrects(); // busca
    //await Future.delayed(Duration(seconds: 1));
    yield await questionsIncorrects.getQuestionsIncorrects();
    // await Future.delayed(Duration(seconds: 1));
    yield await nextPage();
  }

  late final StreamController _controller = StreamController(
    onListen: () {
      _controller.addStream(getDatas());
    },
    onCancel: () {
      _controller.close();
    },
  );

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(),
                    Text(
                      'Aguardando dados...',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ],
                );
              case ConnectionState.waiting:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Loading(),
                    Text(
                      '${widget.msgPrimary}...',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ],
                );
              case ConnectionState.active:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Loading(),
                    Text(
                      '${widget.msgSecundary}...',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ],
                );
              case ConnectionState.done:
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Loading(),
                    Text(
                      'Pronto!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    ),
                  ],
                );
            }
          }
        },
      ),
    );
  }
}
