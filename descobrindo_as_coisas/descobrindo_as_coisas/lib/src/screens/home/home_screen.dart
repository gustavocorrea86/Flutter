import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterTts flutterTts = FlutterTts();
  String textColorsAndYourNames = 'Cores e seus nomes';

  Future voice(String text) async {
    await flutterTts.setLanguage('pt-BR');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descobrindo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'colorAndWord');
                  },
                  child: Text('Cores e seus nomes'),
                ),
                // IconButton(
                //   onPressed: () {
                //     voice(textColorsAndYourNames);
                //   },
                //   icon: Icon(Icons.volume_up),
                // ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'memoryPlay');
              },
              child: Text('Jogo da mémoria com letras'),
            ),
            
          ],
        ),
      ),
    );
  }
}
