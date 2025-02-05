import 'package:flutter/material.dart';

class ListSelectedDisciplines extends StatelessWidget {
  final List<String> list;
  const ListSelectedDisciplines({required this.list, super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scrollbar(
        thumbVisibility: true,
        controller: scrollController,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: const BoxDecoration(
              //color: Colors.white12,
              ),
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, int index) {
                return Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green, size: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        ' ${list[index]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
