import 'package:estudamais/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedButtonRectangular extends StatefulWidget {
  final String title;
  final Function onTap;
  final String? tralling;
  final String? leading;
  final double? fontSizeTitle;
  final MainAxisAlignment? textDirection;
  bool enable = false;
  AnimatedButtonRectangular(
      {required this.title,
      required this.onTap,
      this.tralling,
      this.leading,
      this.fontSizeTitle = 18.0,
      this.textDirection,
      super.key});

  @override
  State<AnimatedButtonRectangular> createState() =>
      _AnimatedButtonRetangulareState();
}

class _AnimatedButtonRetangulareState extends State<AnimatedButtonRectangular> {
  //bool enable = false;
  double buttonDown = 8;
  Color shadowColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: shadowColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: buttonDown,
                duration: const Duration(
                  milliseconds: 60,
                ),
                child: GestureDetector(
                  onTap: () {
                    widget.enable = !widget.enable;
                    value.actionBtnRetangulare = !value.actionBtnRetangulare;
                    setState(() {
                      if (widget.enable) {
                        value.actionBtnRetangulare = widget.enable;
                        buttonDown = 2;
                        shadowColor = Colors.white;
                        print(value.actionBtnRetangulare);
                        widget.onTap();
                      } else {
                        value.actionBtnRetangulare = widget.enable;
                        buttonDown = 8;
                        shadowColor = Colors.black87;
                        print(value.actionBtnRetangulare);
                        widget.onTap();
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: MediaQuery.of(context).size.width - 65,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: widget.textDirection ??
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: widget.fontSizeTitle,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 15),
                          child: Column(
                            children: [
                              Text(
                                widget.leading ?? '',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                widget.tralling ?? '',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    // ListTile(
                    //   leading: Text(
                    //     widget.leading ?? '',

                    //   ),
                    //   title: Text(
                    //     widget.title,
                    //     style: TextStyle(
                    //         fontSize: widget.fontSizeTitle,
                    //         color: Colors.amber),
                    //   ),
                    //   trailing: Text(
                    //     widget.tralling ?? '',
                    //     style:
                    //         const TextStyle(fontSize: 10, color: Colors.white),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
