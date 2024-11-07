import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: const Color.fromARGB(153, 255, 255, 255),
        surfaceTintColor: Colors.indigo,
        child: ListTile(
          leading: image,
          title: Text(
            value,
            style: const TextStyle(fontSize: 30),
          ),
          subtitle: Text(description),
          trailing: textButton
        ),
      ),
    );
  }
}
