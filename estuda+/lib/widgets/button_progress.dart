import 'package:estudamais/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonProgress extends StatefulWidget {
  Function actionButton;

  ButtonProgress(this.actionButton, {super.key});

  @override
  State<ButtonProgress> createState() => _ButtonProgressState();
}

class _ButtonProgressState extends State<ButtonProgress>
    with TickerProviderStateMixin {
  late AnimationController controller;
  String textLinearProgress = 'Buscar';
  double widht = 120;
  double height = 40;
  Color colorBtn = Colors.black38;
  Color colorLinearProgress = Colors.blue;
  Color colorTextBtn = Colors.white;
  bool selected = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    controller.stop();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startAnimation() {
    setState(() {
      selected = !selected;
      if (selected) {
        widht = 250;
        height - 40;
      }
    });
    buttonProgress();
  }

  Future<String?> withOutFind() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nenhum campo foi selecionado.'),
            content: const Text('Verifique e tente novamente.'),
            actions: [
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void buttonProgress() {
    bool findError =
        (Provider.of<ModelPoints>(context, listen: false).progressError);
    Future.delayed(const Duration(milliseconds: 2300)).then((value) {
      if (widht == 250) {
        textLinearProgress = 'Buscando...';
        setState(() {
          controller.forward(from: controller.value);

          Future.delayed(const Duration(milliseconds: 3500)).then((value) {
            if (controller.isCompleted) {
              setState(() {
                colorTextBtn = Colors.black87;
                textLinearProgress = 'Pronto!';
                Future.delayed(const Duration(milliseconds: 300)).then((value) {
                  if (findError) {
                    print('findError $findError');
                    setState(() {
                      colorLinearProgress = Colors.red;
                      textLinearProgress = 'Ops, algo de errado!';
                    });
                  } else {
                    widget.actionButton();
                  }
                });
              });
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (value.actionBtnCircle) {
              startAnimation();
            } else {
              withOutFind();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.fastEaseInToSlowEaseOut,
            width: selected ? widht = 250 : widht,
            height: selected ? height : height,
            decoration: BoxDecoration(
                //color: Colors.indigo,
                color: Colors.black38,
                borderRadius: BorderRadius.circular(20)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.black38,
                  color: colorLinearProgress,
                  value: controller.value,
                  minHeight: 40,
                  borderRadius: BorderRadius.circular(20),
                ),
                Text(
                  textLinearProgress,
                  style: TextStyle(
                    color: colorTextBtn,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
