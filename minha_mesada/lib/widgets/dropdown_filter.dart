import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:minha_mesada/service/service.dart';

class DropdownFilter extends StatefulWidget {
  final String hintText;
  const DropdownFilter(this.hintText, {super.key});

  @override
  State<DropdownFilter> createState() => _DropdownFilterState();
}

class _DropdownFilterState extends State<DropdownFilter> {
  final List<String> items = ['Opção 1', 'Opção 2', 'Opção 3'];
  //List<String> subjects = Service.listSubjects.toSet().toList();

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
            items: Service.listSubjects
                .map((String item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            value: selectValue,
            onChanged: (String? value) {
              setState(() {
                
                selectValue = value;
              });
              print('Disciplina Selecionada: $selectValue');
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
