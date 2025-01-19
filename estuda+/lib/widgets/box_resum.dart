import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BoxResum extends StatelessWidget {
  Widget image;
  String value;
  String description;
  TextButton textButton;

  BoxResum(this.value, this.description, this.image, this.textButton,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4, bottom: 4, right: 8),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(190, 197, 202, 233),
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 2.0,
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: image,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(),

                  //width: 150,
                  height: 90,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          style: GoogleFonts.aboreto(
                            fontSize: 30,
                          ),
                        ),
                        Text(description,
                            style: GoogleFonts.aboreto(
                                fontSize: 13, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(207, 121, 135, 203),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                //width: 40,
                height: 90,
                child: RotatedBox(quarterTurns: -1, child: textButton),
              )
            ],
          ),
        ));
  }
}
