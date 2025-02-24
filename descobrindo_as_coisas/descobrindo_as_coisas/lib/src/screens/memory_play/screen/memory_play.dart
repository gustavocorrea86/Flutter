import 'package:descobrindo_as_coisas/src/model/counter.dart';
import 'package:descobrindo_as_coisas/src/model/states.dart';
import 'package:descobrindo_as_coisas/src/screens/memory_play/components/card_letters.dart';
import 'package:flutter/material.dart';

class MemoryPlay extends StatefulWidget {
  const MemoryPlay({super.key});

  @override
  State<MemoryPlay> createState() => _MemoryPlayState();
}

class _MemoryPlayState extends State<MemoryPlay> {
  States states = States();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jogo da Memória'),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Counter.count = 0;
                states.isMatch = false;
                states.isFlipped = true;

                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 64, 7, 90),
                    const Color.fromARGB(255, 48, 75, 228),
                    const Color.fromARGB(255, 64, 7, 90),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //height: 600,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white24),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: CardLetters()),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
