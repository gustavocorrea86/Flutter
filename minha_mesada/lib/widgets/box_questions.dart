import 'package:flutter/material.dart';

class BoxQuestions extends StatelessWidget {
  final String question;
  const BoxQuestions(this.question,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Center(child: Text(question, style: TextStyle(fontSize: 20) ,)),
        ),
      ),
    );
  }
}
