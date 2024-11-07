import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  String text;
  bool? checked;
  CheckboxWidget(this.text, {this.checked = false, super.key});

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        secondary: const Icon(Icons.subject),
        title: Text(widget.text),
        value: widget.checked,
        onChanged: (bool? value) {
          setState(() {
            widget.checked = value;
            if (widget.checked == true) {
              print(widget.text);
            }
          });
        });
  }
}
