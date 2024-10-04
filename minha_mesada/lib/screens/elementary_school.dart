import 'package:flutter/material.dart';

class ElementarySchool extends StatelessWidget {
  const ElementarySchool({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'elementary_school_1');
              },
              child: Text('Ensino fundamental 1')),
          ElevatedButton(onPressed: () {
             Navigator.pushNamed(context, 'elementary_school_2');
          }, child: Text('Ensino fundamental 2'))
        ],
      ),
    );
  }
}
