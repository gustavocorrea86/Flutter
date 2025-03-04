import 'dart:async';

import 'package:estudamais/controller/routes.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/model_questions.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/screens/home/home.dart';
import 'package:estudamais/service/questions_corrects.dart';
import 'package:estudamais/service/questions_incorrets.dart';
import 'package:estudamais/service/service.dart';
import 'package:flutter/material.dart';
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
    DaoUserResum().findIdQuestions();
    DaoUserResum().findIdQuestionsIncorrect();
    DaoUserResum().findIdQuestionsCorrect();
    // carrega os ids das questões
    super.initState();
  }

  nextPage() {
    Provider.of<ModelPoints>(context, listen: false)
        .uptadeCorrects(DaoUserResum.listIdCorrects.length);
    Provider.of<ModelPoints>(context, listen: false)
        .updateIncorrects(DaoUserResum.listIdIncorrects.length);
    QuestionsCorrects().counterDisciplineCorrects();
    // busca as disciplinas respondidas incorretamente
    QuestionsIncorrects().counterDisciplineIncorrects();
    // chama a homeScreen
    Routes().pushRoute(context, const HomeScreen());
  }

  Stream getDatas() async* {
    // busca todas as questões
    yield await service.getQuestions();
    print('1');
    // busca os ids das questões respondidad corretamente
    yield await questionsCorrects.getQuestionsCorrects();
    print('2');
    // busca os ids das questões respondidas incorretamente
    yield await questionsIncorrects.getQuestionsIncorrects();
    print('3');
    // atualiza o progresso do usuario
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
