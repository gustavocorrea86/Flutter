import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_ritgh.dart';

class Subject extends StatefulWidget {
  String subject;
  String legthSubject;

  Subject(this.legthSubject, this.subject, {super.key});

  @override
  State<Subject> createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  bool enable = false;
  double paddingLeft1 = 10.0;
  double paddingLeft2 = 20.0;
  double paddingRight1 = 10.0;
  double paddingRight2 = 20.0;
  DaoRight databaseRight = DaoRight();

  _onTap() {
    setState(() {
      enable = !enable;
      print(enable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onTap();
        //DaoRight().findForSubjectOfRight(widget.subject);

        if (enable == true) {
          databaseRight.getQuestions(widget.subject);
        } else {
          databaseRight.removeQuestions(widget.subject);
        }
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(
            left: enable ? paddingLeft1 : paddingLeft2,
            right: enable ? paddingRight1 : paddingRight2,
            top: 2.0,
            bottom: 2.0),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(2.0, 2.0),
                color: Colors.black12,
                blurRadius: 4.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: enable ? Colors.indigo : Colors.blueGrey),
        child: ListTile(
          //leading: Text(legthSubject),
          title: Text(
            widget.subject,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          trailing: Text(
            '${widget.legthSubject} questões',
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
