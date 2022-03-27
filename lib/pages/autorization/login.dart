import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prohojemba/pages/mainPage.dart';
import 'package:prohojemba/pages/autorization/register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int backButtonClickCounter = 0;
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
            child: _loginForm()
          ),
        )
      )
    );
  }

  //Форма логина
  Widget _loginForm() => Column(
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
              _welcomeNote(),
              _input(),
              _buttons()
            ],
          ),
        ),
      ),
      _about()
    ],
  );

  //Приветственное сообщение
  Widget _welcomeNote() => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text("Здравствуй, Проходжембец!",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      )
    ),
  );

  //Блок с полями для ввода информации
  Widget _input() => Container(
    child: Column(
      children: <Widget> [
        //Поле для ввода почты
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoTextField(
            textInputAction: TextInputAction.next,
            restorationId: 'email_address_text_field',
            placeholder: 'Сюдой введи почту',
            keyboardType: TextInputType.emailAddress,
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
          ),
        ),
        //Поле для ввода пароля
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoTextField(
            textInputAction: TextInputAction.next,
            restorationId: 'email_address_text_field',
            placeholder: 'Сюдой введи пароль',
            keyboardType: TextInputType.emailAddress,
            clearButtonMode: OverlayVisibilityMode.editing,
            autocorrect: false,
          ),
        ),
      ],
    ),
  );

  //Блок с кнопками
  Widget _buttons() => Column (
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget> [
      //Кнопка "Войти"
      Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
          onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())); backButtonClickCounter = 0; },
          child: Text(
              "Войти",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            ),
            color: Color.fromRGBO(100, 100, 100, 1),
          ),
        ),
      ),
      //Кнопка "Зарегистрироваться"
      Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
          onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Register())); backButtonClickCounter = 0; },
          child: Text(
              "Зарегистрироваться",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            ),
            color: Color.fromRGBO(100, 100, 100, 1),
          ),
        ),
      ),
    ],
  );
  
  //Поле с дополнительной информацией
  Widget _about() => Text('Presented by StarPony Inc. 2022');
}