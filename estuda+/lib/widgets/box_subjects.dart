import 'package:flutter/material.dart';

class BoxSubjectsAndSchoolYear extends StatefulWidget {
  final String subject;
  final String schoolYear;
  const BoxSubjectsAndSchoolYear(
      {required this.subject, required this.schoolYear, super.key});

  @override
  State<BoxSubjectsAndSchoolYear> createState() =>
      _BoxSubjectsAndSchoolYearState();
}

class _BoxSubjectsAndSchoolYearState extends State<BoxSubjectsAndSchoolYear> {
  bool enable = false;
  Color backgroundButton = Colors.black38;
  Color textButton = Colors.white;
  double widthBorder = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          decoration: BoxDecoration(
            color: backgroundButton,
            border: Border.all(
              width: widthBorder,
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            minLeadingWidth: 2,
            minTileHeight: 5,
            onTap: () {
              setState(
                () {
                  enable = !enable;
                  if (enable) {
                    textButton = Colors.indigo;
                    backgroundButton = Colors.white;
                    widthBorder = 3;
                    print(widget.subject);
                  } else {
                    textButton = Colors.white;
                    backgroundButton = Colors.black45;
                    widthBorder = 0;
                  }
                },
              );
            },
            leading: Visibility(
              visible: enable,
              child: const Icon(
                Icons.check,
                color: Colors.green,
                size: 25,
              ),
            ),
            title: Text(
              widget.subject,
              style: TextStyle(
                color: textButton,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            trailing: Text(
              widget.schoolYear,
              style: TextStyle(
                color: textButton,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          )),
    );
  }
}
