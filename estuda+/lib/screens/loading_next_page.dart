import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_user_resum.dart';
import 'package:estudamais/models/models.dart';
import 'package:estudamais/widgets/loading.dart';
import 'package:provider/provider.dart';

class LoadingNextPage extends StatefulWidget {
  const LoadingNextPage({super.key});

  @override
  State<LoadingNextPage> createState() => _LoadingNextPageState();
}

class _LoadingNextPageState extends State<LoadingNextPage> {
  @override
  void initState() {
    DaoUserResum()
        .findAnswered(); // faz busca do total de perguntas respondidas
    nextPage();

    super.initState();
  }

  nextPage() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushNamed(context, 'home');
      //DaoRight().lenghtSubject();
      Provider.of<ModelPoints>(context, listen: false)
          .showPoints(DaoUserResum.totalPoints);
      Provider.of<ModelPoints>(context, listen: false)
          .showErrors(DaoUserResum.totalErrors);
      Provider.of<ModelPoints>(context, listen: false)
          .counterOfAnswereds(DaoUserResum.answeredQuestions);
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Loading(),
    );
  }
}
