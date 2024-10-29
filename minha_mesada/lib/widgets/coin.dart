import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  final Color cor1;
  final Color cor2;
  final Color cor3;
  const Coin(this.cor1, this.cor2, this.cor3, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        
        border: Border.all(width: 1, color: const Color.fromARGB(255, 151, 151, 151)),
        color: Colors.amber,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.black26,
            blurRadius: 2,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: const Alignment(.2, 1),
          colors: <Color>[cor1, cor2, cor3],
        ),
        shape: BoxShape.circle,
        image: const DecorationImage(
            image:
                AssetImage('./assets/images/finance-634901_640.png'),
            fit: BoxFit.cover,
            opacity: .4),
      ),
    );
  }
}
