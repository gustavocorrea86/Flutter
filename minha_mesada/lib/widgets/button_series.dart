import 'package:flutter/material.dart';

class ButtonSeries extends StatelessWidget {
  const ButtonSeries({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Colors.indigo,
          Colors.lightBlue,
          Colors.indigo
        ],)
      ),
      child: const Text('5º série'),
    );
  }
}