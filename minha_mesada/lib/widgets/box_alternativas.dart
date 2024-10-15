import 'package:flutter/material.dart';
import 'package:mongodb_api/database/dao_user.dart';

class BoxAlternatives extends StatefulWidget {
  // final Color cor;
  final String alt;
  final String option;
  final String response;
  final String? correct;

  BoxAlternatives(this.alt, this.option, this.response,
      {this.correct, super.key});

  @override
  State<BoxAlternatives> createState() => _BoxAlternativesState();
}

class _BoxAlternativesState extends State<BoxAlternatives> {
  Color corAlternativa = Colors.white;
  int count = 0;
  String userPoints = DaoQuizUser.userPoints;
  String hitOrErr = '';
  double widthContainer = 0;
  double heightContainer = 0;

  changeColors() {
    if (widget.response == widget.alt) {
      corAlternativa = Colors.green;
      count++;
      int points = count;
      DaoQuizUser().addPoints('Gustavo', points);

      DaoQuizUser().findPoints('Gustavo');
      print('Pontos do usuario: $userPoints');
      hitOrErr = 'Acertou!';
      widthContainer = 70;
      heightContainer = 20;
    } else {
      corAlternativa = Colors.red;
      hitOrErr = 'Errou';
      widthContainer = 70;
      heightContainer = 20;
    }
    return Text(hitOrErr);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: MediaQuery.of(context).size.width,
              // height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 3),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
                color: corAlternativa,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.black38,
                ),
              ),
              child: InkWell(
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: Colors.black26),
                        color: Colors.white),
                    child: Text(
                      widget.option,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  title: Text(
                    widget.alt,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                onTap: () {
                  setState(() {
                    print(widget.response);
                    changeColors();
                  });
                },
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    alignment: Alignment.center,
                    width: widthContainer,
                    height: heightContainer,
                    decoration: BoxDecoration(
                        color: corAlternativa,
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      hitOrErr,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
