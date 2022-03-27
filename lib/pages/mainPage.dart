import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prohojemba/pages/autorization/login.dart';
import 'package:prohojemba/pages/profile.dart';
import 'package:prohojemba/pages/viewstats.dart';
import 'package:prohojemba/pages/newstat.dart';

import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int backButtonClickCounter = 0;
  
  Future<String> _getUserInfo() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    return User.fromJson(jsonDecode(response.body)).userName;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (backButtonClickCounter >= 1) {
          exit(0);
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Нажмите ещё раз для выхода из приложения')));
        backButtonClickCounter++;
        return false;
      },
      child: Scaffold(
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("pictures/background.png"),
                  fit: BoxFit.cover
                )
              ),
            child: _mainPage()
          ),
        )
      )
    );
  }

  //Главная страница
  Widget _mainPage() => Column(
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
              const SizedBox(height: 10),
              Text('Вы авторизовались как'),
              const SizedBox(height: 10),
              _avatar(),
              const SizedBox(height: 10),
              _userName(),
              const SizedBox(height: 10),
              _buttons()
            ],
          ),
        ),
      ),
      _about()
    ],
  );

  //Блок с информацией о пользователе
  Widget _userInfo() => Container(
    child: Column(
      children: <Widget> [
        _userName(),
        _avatar()
      ],
    ),
  );

  //Отображение имени пользователя
  Widget _userName() => FutureBuilder<String>(
    future: _getUserInfo(),
    builder:(context, snapshot) {
      if (snapshot.hasData) {
        return Text(
          snapshot.data,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        );
      }
      return CircularProgressIndicator();
    }
    
  );

  //Отображение аватара пользователей
  Widget _avatar() => Container(
    width: 100.0,
    height: 100.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("pictures/icon.png"),
        fit: BoxFit.cover
      ),
    ),
  );

  //Блок с кнопками
  Widget _buttons() => Container(
    child: Column(
      children: <Widget> [
        _profile(),
        _viewStats(),
        _newStat(),
        _logout()
      ],
    ),
  );

  //Кнопка перехода на страницу профиля
  Widget _profile() => Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())); backButtonClickCounter = 0; },
      child: Text(
          "Профиль",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        color: Color.fromRGBO(100, 100, 100, 1),
      ),
    ),
  );

  //Кнопка перехода на страницу со статистикой
  Widget _viewStats() => Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStats())); backButtonClickCounter = 0; },
      child: Text(
          "Смотреть статистику",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        color: Color.fromRGBO(100, 100, 100, 1),
      ),
    ),
  );

  //Кнопка перехода на страницу со статистикой
  Widget _newStat() => Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => NewStat())); backButtonClickCounter = 0; },
      child: Text(
          "Сделать запись",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        color: Color.fromRGBO(100, 100, 100, 1),
      ),
    ),
  );

  //Кнопка выхода из аккаунта
  Widget _logout() => Container(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); backButtonClickCounter = 0; },
      child: Text(
          "Сменить аккаунт",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        color: Color.fromRGBO(100, 100, 100, 1),
      ),
    ),
  );

  //Поле с дополнительной информацией
  Widget _about() => Text('Presented by StarPony Inc. 2022');
}

class User {
  final String userName;

  const User({
    @required this.userName
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['title']
    );
  }
}