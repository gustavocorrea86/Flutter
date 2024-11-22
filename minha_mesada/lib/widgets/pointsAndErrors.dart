import 'package:flutter/material.dart';
import 'package:minha_mesada/controller/counter_errors.dart';
import 'package:minha_mesada/controller/counter_points.dart';
import 'package:minha_mesada/models/models.dart';
import 'package:provider/provider.dart';

class PointsAndErrors extends StatelessWidget {
  PointsAndErrors({super.key});
  CounterErrors counterErrors = CounterErrors();

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelPoints>(
      builder: (context, storedValue, child) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 2),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Text(
                    CounterPoints.points.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            Container(
              width: 50,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
              ),
              child: Text(
                CounterErrors.errors.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
