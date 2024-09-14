import 'package:flutter/material.dart';

class Boxcard extends StatefulWidget {
  final String name;
  final String number;
  final IconButton delete;
  final IconButton update;
  const Boxcard(this.update, this.delete, this.name, this.number, {super.key});

  @override
  State<Boxcard> createState() => _BoxcardState();
}

class _BoxcardState extends State<Boxcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
              title: Text(
                widget.name,
                style: TextStyle(fontSize: 23),
              ),
              subtitle: Text(widget.number),
              leading: Icon(Icons.contact_phone),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [widget.delete, widget.update],
                ),
              )),
        ],
      ),
    );
  }
}
