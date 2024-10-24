import 'package:flutter/material.dart';

class ElementarySchool1 extends StatelessWidget {
  const ElementarySchool1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){}, child: const Text('1º Ano')),
          ElevatedButton(onPressed: (){}, child: const Text('2º Ano')),
          ElevatedButton(onPressed: (){}, child: const Text('3º Ano')),
          ElevatedButton(onPressed: (){}, child: const Text('4º Ano')),
          ElevatedButton(onPressed: (){}, child: const Text('5º Ano')),
          
        ],
      ),
    );
  }
}