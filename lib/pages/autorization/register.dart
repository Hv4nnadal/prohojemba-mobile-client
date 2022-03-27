import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prohojemba/pages/autorization/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int _currentStep = 0;

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
          child: _registerForm()
        ),
      )
    );
  }

  //Форма регистрации
  Widget _registerForm() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget> [ 
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
            children: [
              _welcomeNote(),
              _input(),
              _buttons()
            ],
          ),
        )
      ),
      _about(),
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
    child: Stepper(
      controlsBuilder:
      (BuildContext context, ControlsDetails details) {
         return Row(
           children: <Widget>[
             TextButton(
               onPressed: details.onStepContinue,
               child: Text('Продолжить'),
             ),
             TextButton(
               onPressed: details.onStepCancel,
               child: Text('Назад'),
             ),
           ],
         );
      },
      type: StepperType.vertical,
      steps: <Step> [
        Step(
          title: Text("Введите свой e-mail"),
          content: Padding(
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
        ),
        Step(
          title: Text("Придумайте пароль"),
          content: Column(
            children: <Widget> [
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'email_address_text_field',
                  placeholder: 'Сюдой введи пароль ышчо раз',
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                ),
              ),
            ],
          ) 
        ),
        Step(
          title: Text("Активируйте аккаунт"),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget> [
                Text("На указанную почту было выслано письмо с кодом подтверждения. Введите его в поле ниже:"),
                Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoTextField(
                  textInputAction: TextInputAction.next,
                  restorationId: 'email_address_text_field',
                  placeholder: 'Сюдой введи код',
                  keyboardType: TextInputType.emailAddress,
                  clearButtonMode: OverlayVisibilityMode.editing,
                  autocorrect: false,
                ),
              ),
              ]
            ),
          ),
        ),
      ],
      onStepTapped: (int newIndex) {
        setState(() {
          _currentStep = newIndex;
        });
      },
      currentStep: _currentStep,
      onStepContinue: () {
        if (_currentStep != 2) {
          setState(() {
            _currentStep += 1;
          });
        }
      },
      onStepCancel: () {
        if (_currentStep != 0) {
          setState(() {
            _currentStep -= 1;
          });
        }
      },
    ),
  );

  //Блок с кнопками
  Widget _buttons() => Column (
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget> [
      //Кнопка "Зарегистироваться"
      Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
          onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); },
          child: Text(
              "Зарегистироваться",
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