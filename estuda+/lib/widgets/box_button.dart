import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxButton extends StatelessWidget {
  String textPrimary;
  String textSecondary;
  BoxButton(this.textPrimary, this.textSecondary, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 128, 147, 253),
              Color.fromARGB(255, 68, 85, 180),
              Color.fromARGB(255, 68, 85, 180)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          //borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              blurRadius: 7,
              blurStyle: BlurStyle.normal,
              offset: Offset(0.0, 0.2),
            )
          ]),
      child: GridTile(
        //footer: Text(elementarySchool, style: GoogleFonts.aboreto(fontSize: 10), ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textPrimary,
              style: GoogleFonts.aboreto(
                fontSize: 20,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 7,
                    offset: Offset(0.0, 2.0),
                  )
                ],
              ),
            ),
            Text(
              textSecondary,
              style: GoogleFonts.aboreto(
                fontSize: 10,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 7,
                    offset: Offset(0.0, 2.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
