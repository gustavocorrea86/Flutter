import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownFilter extends StatefulWidget {
  final String hintText;
  final List<String> options;

  const DropdownFilter(this.hintText,this.options,  {super.key});

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  //List series = Service().getSeries();
  @override
  void initState() {
    super.initState();
    //Service().getSeries();
  }

  String? selectValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(widget.hintText),
            items: widget.options
                .map((String item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            value: selectValue,
            onChanged: (String? value) {
              setState(() {
                selectValue = value;
                //Service().findSubjectsBySerie(value!);
              });
              print(selectValue);
            },
            buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 150,
                decoration: BoxDecoration(color: Colors.white)),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      ),
    );
  }
}
