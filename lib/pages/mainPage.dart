import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prohojemba/pages/autorization/login.dart';
import 'package:prohojemba/pages/profile.dart';
import 'package:prohojemba/pages/viewstats.dart';
import 'package:prohojemba/pages/newstat.dart';

import 'package:http/http.dart' as http;

int backButtonClickCounter = 0;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
        drawer: NavDrawer(),
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
              const SizedBox(height: 10),
              _buttons()
            ],
          ),
        ),
      ),
      _about()
    ],
  );



  //Блок с кнопками
  Widget _buttons() => Container(
    child: Column(
      children: <Widget> [
        Text("Тута будет главная страница")
      ],
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
  //Поле с дополнительной информацией
  Widget _about() => Text('Presented by StarPony Inc. 2022');
}

class NavDrawer extends StatelessWidget {
  Future<String> _getUserInfo() async {
    var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    return User.fromJson(jsonDecode(response.body)).userName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: _userInfo(),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("pictures/drawerBack.png")
              )
            ),
          ),
          
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Профиль'),
            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())); backButtonClickCounter = 0; },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Статистика'),
            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStats())); backButtonClickCounter = 0; },
          ),
          ListTile(
            leading: Icon(Icons.library_add),
            title: Text('Сделать запись'),
            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => NewStat())); backButtonClickCounter = 0; },
          ),
          Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Сменить аккаунт'),
            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); backButtonClickCounter = 0; },
          ),
        ]
      )
    );
  }

    //Блок с информацией о пользователе
  Widget _userInfo() => Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        _avatar(),
        const SizedBox(height: 20),
        Text(
          'Вы авторизовались как',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white
          ),
        ),
        const SizedBox(height: 5),
        _userName(),
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
            fontSize: 20,
            color: Colors.white
          ),
        );
      }
      return SizedBox(
        child: CircularProgressIndicator(),
        height: 20,
        width: 20,
      );
    }
    
  );

  //Отображение аватара пользователей
  Widget _avatar() => Container(
    width: 70.0,
    height: 70.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("pictures/icon.png"),
        fit: BoxFit.cover
      ),
    ),
  );
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