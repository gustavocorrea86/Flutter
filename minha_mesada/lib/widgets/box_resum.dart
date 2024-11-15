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
          //height: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(178, 255, 255, 255),
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
              Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(176, 121, 135, 203),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                     boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26.withOpacity(0.2),
                        spreadRadius: 2.0,
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: image,
                  )),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(190, 197, 202, 233),
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //     color: Colors.black26.withOpacity(0.2),
                    //     spreadRadius: 3.0,
                    //     blurRadius: 2.0,
                    //   ),
                    // ],
                  ),

                  //width: 150,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value,
                          style: GoogleFonts.neucha(fontSize: 30),
                        ),
                        Text(
                          description,
                          style: GoogleFonts.neucha(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    // boxShadow: <BoxShadow>[
                    //     BoxShadow(
                    //       color: Colors.black26.withOpacity(0.2),
                    //       spreadRadius: 2.0,
                    //       blurRadius: 2.0,
                    //     ),
                    //   ],
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                //width: 40,
                height: 100,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: textButton,
                ),
              )
            ],
          ),
        )

        // Card(
        //     color: const Color.fromARGB(153, 255, 255, 255),
        //     surfaceTintColor: Colors.indigo,
        //     child: ListTile(
        //       onTap: () {},
        //       leading: image,
        //       title: Text(
        //         value,
        //         style: GoogleFonts.neucha(fontSize: 30),
        //       ),
        //       subtitle: Text(
        //         description,
        //         style: GoogleFonts.neucha(
        //             fontSize: 18, fontWeight: FontWeight.bold),
        //       ),
        //       trailing: Expanded(
        //         child: Container(
        //           height: 85,
        //           decoration: BoxDecoration(
        //               color: Color.fromARGB(171, 68, 137, 255),
        //               borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(10),
        //                   bottomRight: Radius.circular(10))),
        //           child: textButton,
        //         ),
        //       ),
        //     )
        //     //Container(
        //     //     height: 85,
        //     //     decoration: BoxDecoration(
        //     //       color: Color.fromARGB(171, 68, 137, 255),
        //     //       // borderRadius: BorderRadius.only(
        //     //       //     topRight: Radius.circular(10),
        //     //       //     bottomRight: Radius.circular(10))),
        //     //       //width: 100,
        //     //     )),
        //     ),
        );
  }
}
