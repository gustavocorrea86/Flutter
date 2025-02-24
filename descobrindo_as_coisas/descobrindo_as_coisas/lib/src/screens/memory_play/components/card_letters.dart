import 'package:descobrindo_as_coisas/src/components/back_card.dart';
import 'package:descobrindo_as_coisas/src/components/flip_card.dart';
import 'package:descobrindo_as_coisas/src/components/front_card.dart';
import 'package:descobrindo_as_coisas/src/model/controller_accept.dart';
import 'package:descobrindo_as_coisas/src/model/counter.dart';
import 'package:descobrindo_as_coisas/src/model/states.dart';
import 'package:descobrindo_as_coisas/src/screens/memory_play/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardLetters extends StatefulWidget {
  const CardLetters({super.key});

  @override
  State<CardLetters> createState() => _CardLettersState();
}

class _CardLettersState extends State<CardLetters> {
  States states = States();
  Widget cards() {
    Helpers.letter.shuffle();
    return Consumer<ControllerAccept>(builder: (context, value, child) {
      return Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(Helpers.letter.length, (int index) {
              return FlipCard(
                frontCard: FrontCard(
                  text: Helpers.letter[index],
                ),
                contentCard: Helpers.letter[index],
                backCard: BackCard(
                  letter: Helpers.letter[index],
                  borderColor: Colors.white,
                  //key: idWidget,
                  isBorder: value.isBorder,
                  widthBorder: value.bordeCards,
                ),
              );
            }),
          ),
          ElevatedButton(
              onPressed: () {
                Counter.count = 0;
                states.isMatch = false;
                states.isFlipped = true;
                Navigator.pop(context);
              },
              child: Text('Sair'))
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return cards();
  }
}
