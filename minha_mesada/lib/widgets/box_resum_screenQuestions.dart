import 'package:flutter/material.dart';

class BoxResumScreenQuestions extends StatelessWidget {
  final String text;
  final Widget image;
  final double widthPadding;
  const BoxResumScreenQuestions(this.text, this.image,this.widthPadding, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image,
                  Padding(
                    padding: EdgeInsets.all(widthPadding),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
