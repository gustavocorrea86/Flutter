import 'package:flutter/material.dart';

class BoxResum extends StatelessWidget {
  Widget image;
  String value;
  String description;

  BoxResum(this.value, this.description, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        surfaceTintColor: Colors.indigo,
        child: ListTile(
            leading: image,
            title: Text(
              value,
              style: const TextStyle(fontSize: 30),
            ),
            subtitle: Text(description),
            trailing: TextButton(
                onPressed: () {},
                child: const Text(
                  'Detalhes',
                  style: TextStyle(fontSize: 20),
                ))),
      ),
    );
  }
}
