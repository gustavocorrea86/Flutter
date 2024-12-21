import 'package:flutter/material.dart';
import 'package:estudamais/database/dao_ritgh.dart';

class AnimatedBoxSubject extends StatefulWidget {
  bool enable = false;
  String textSubject;
  String textLengthSubject;
  dynamic daoDatabase;
  AnimatedBoxSubject(
      this.enable, this.textSubject, this.textLengthSubject, this.daoDatabase,
      {super.key});

  @override
  State<AnimatedBoxSubject> createState() => _AnimatedBoxSubjectState();
}

class _AnimatedBoxSubjectState extends State<AnimatedBoxSubject> {
  double paddingLeft1 = 10.0;
  double paddingLeft2 = 20.0;
  double paddingRight1 = 10.0;
  double paddingRight2 = 20.0;
  DaoRight databaseRight = DaoRight();
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(
          left: widget.enable ? paddingLeft1 : paddingLeft2,
          right: widget.enable ? paddingRight1 : paddingRight2,
          top: 2.0,
          bottom: 2.0),
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(2.0, 2.0),
              color: Colors.black12,
              blurRadius: 4.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: widget.enable ? Colors.indigo : Colors.blueGrey),
      child: ListTile(
        onTap: () {
          setState(() {
            widget.enable = !widget.enable;
            if (widget.enable) {
              widget.daoDatabase.getQuestions(widget.textSubject);
              //print('index = $index');
              //test = index;
            } else {
              widget.daoDatabase.removeQuestionsDetails(widget.textSubject);
            }
          });
        },
        //leading: Text(legthSubject),
        title: Text(
          widget.textSubject,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        trailing: Text(
          '${widget.textLengthSubject} questões',
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
