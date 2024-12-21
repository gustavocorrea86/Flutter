import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:estudamais/models/models.dart';
import 'package:provider/provider.dart';

class ListTileDrawer extends StatelessWidget {
  final String displice;
  final String dipliceURL;
  ListTileDrawer(this.displice, this.dipliceURL, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(builder: (context, value, child) {
      return ListTile(
        title: Text(
          displice,
          style: GoogleFonts.robotoFlex(fontSize: 20),
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.pushNamed(context, 'schoolYears');
          value.displiceUrl(dipliceURL);
          print(value.displiceURL);
          value.titleDisp(displice);
        },
      );
    });
  }
}
