import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('./assets/lotties/Animation_cubes.json', width: 200, height: 200)
          // Lottie.network(
          //     'https://lottie.host/14e6645a-b8fd-4dfe-bf6e-1d8f8b81cc44/7GsukhT0EK.json',
          //     width: 200,
          //     height: 200),
          // const Text('Carregando...')
        ],
      ),
    );
  }
}
