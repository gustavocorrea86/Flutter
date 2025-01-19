import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxButton extends StatefulWidget {
  final String textPrimary;
  final double shadowBox;
  String? textSecondary;
  final double widthButton;
  final double heightButton;
  final double fontSizePrimary;
  final Color shadowColor;

  BoxButton(this.textPrimary, this.shadowBox, this.widthButton,
      this.heightButton, this.fontSizePrimary, this.shadowColor,
      {this.textSecondary, super.key});

  @override
  State<BoxButton> createState() => _BoxButtonState();
}

class _BoxButtonState extends State<BoxButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: widget.widthButton + 5,
              height: widget.heightButton + 5,
              decoration: BoxDecoration(
                color: widget.shadowColor,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: widget.shadowBox,
            duration: const Duration(milliseconds: 60),
            child: Container(
              alignment: Alignment.center,
              width: widget.widthButton,
              height: widget.heightButton,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 134, 152, 255),
                    Color.fromARGB(255, 68, 85, 180),
                    Color.fromARGB(255, 68, 85, 180)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.textPrimary ?? 'error',
                    style: GoogleFonts.aboreto(
                      fontSize: widget.fontSizePrimary,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Colors.black54,
                          blurRadius: 7,
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                    ),
                  ),
                  Text(
                    widget.textSecondary ?? '',
                    style: GoogleFonts.aboreto(
                      fontSize: 8,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Colors.black54,
                          blurRadius: 7,
                          offset: Offset(0.0, 3.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
