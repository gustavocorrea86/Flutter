import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Math extends StatelessWidget {
   Math({super.key});
   List<String> test = [
     '1+1 = 2',
     '2+2 = 4',
     '3+3 = 6',
     '4+4 = 8',
     
   ];
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matemática'),
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Lottie.asset('./assets/lotties/backgroud_blue.json',
                fit: BoxFit.cover),
          ),
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0),
                  itemCount: test.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(test[index]),
                  ),
                );
              })

          // GridView.count(
          //   crossAxisCount: 3,
          //   children: <Widget>[
          //    Padding(
          //      padding: const EdgeInsets.all(4.0),
          //      child: Container(

          //       color: Colors.white,
          //      ),
          //    ),
          //    Padding(
          //      padding: const EdgeInsets.all(4.0),
          //      child: Container(

          //       color: Colors.white,
          //      ),
          //    ),
          //    Padding(
          //      padding: const EdgeInsets.all(4.0),
          //      child: Container(

          //       color: Colors.white,
          //      ),
          //    ),
          //    Padding(
          //      padding: const EdgeInsets.all(4.0),
          //      child: Container(

          //       color: Colors.white,
          //      ),
          //    ),

          //   ],
          //   )
        ],
      ),
    );
  }
}
