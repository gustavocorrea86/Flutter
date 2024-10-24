import 'package:flutter/material.dart';

class BoxQuestions extends StatelessWidget {
  final String question;
  const BoxQuestions(this.question, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(question, style: const TextStyle(fontSize: 30),),
    );
  }
}

