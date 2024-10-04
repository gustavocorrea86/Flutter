import 'package:flutter/material.dart';

class ElementarySchool2 extends StatelessWidget {
  const ElementarySchool2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(onPressed: () {}, child: Text('6º Ano')),
          ElevatedButton(onPressed: () {}, child: Text('7º Ano')),
          ElevatedButton(onPressed: () {}, child: Text('8º Ano')),
          ElevatedButton(onPressed: () {}, child: Text('9º Ano')),
        ],
      ),
    );
  }
}
