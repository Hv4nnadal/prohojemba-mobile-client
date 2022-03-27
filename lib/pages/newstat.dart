import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewStat extends StatefulWidget {
  @override
  _NewStatState createState() => _NewStatState();
}

class _NewStatState extends State<NewStat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("pictures/background.png"),
                fit: BoxFit.cover
              )
            ),
          child: _page()
        ),
      )
    );
  }

  Widget _page() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ 
      Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            color: Color.fromRGBO(250, 250, 250, 1),
            borderRadius: BorderRadius.circular(15)
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget> [
              Text("Тута будет добавление нового элемента статистики",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
