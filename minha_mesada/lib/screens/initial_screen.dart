import 'package:flutter/material.dart';

class ScreenInitial extends StatelessWidget {
  const ScreenInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('./assets/images/cubs.png'),fit: BoxFit.cover)
          // gradient: LinearGradient(
          //   colors: [
          //     const Color.fromARGB(255, 247, 204, 140),
          //     Colors.orange,
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Center(
                    child: Text('Login'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context,'userRegister1');
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                        color: Colors.black54,
                        blurRadius: 2,
                        spreadRadius: 1,
                      )]
                  ),
                  child: Center(
                    child: Text('Cadastrar'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
