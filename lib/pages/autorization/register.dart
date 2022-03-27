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
              _input()
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
    child:  Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            _currentStep == 0 ?
            Container(
                child: Row(
                  children: [ TextButton(
                    onPressed: details.onStepContinue,
                    child: Text(
                      'Отправить данные',
                      style: TextStyle(
                        color: Color.fromRGBO(226, 85, 5, 1),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); },
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                        color: Color.fromRGBO(226, 85, 5, 1),
                      ),
                    ),
                  ),
                  ]
                )
            ) : _currentStep == 1 ?
              Container(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: details.onStepContinue,
                      child: Text(
                        'Проверить код',
                        style: TextStyle(
                          color: Color.fromRGBO(226, 85, 5, 1),
                        ),
                        ),
                    ),
                  ]
                )
              ) :
              Container(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Login())); },
                      child: Text(
                        'Перейти к авторизации',
                        style: TextStyle(
                          color: Color.fromRGBO(226, 85, 5, 1),
                        ),
                        ),
                    ),
                  ]
                )
              ),
          ],
        );
      },
      type: StepperType.vertical,
      steps: <Step> [
        Step(
          isActive: _currentStep == 0,
          state: _stepState(0),
          title: Text("Введи данные"),
          content: _registrationFields()
        ),
        Step(
          isActive: _currentStep == 1,
          state: _stepState(1),
          title: Text("Активируй аккаунт"),
          content: _emailVerification()
        ),
        Step(
          isActive: _currentStep == 2,
          state: _stepState(2),
          title: Text("Приступай к использованию"),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget> [
                Text("Аккаунт был успешно активирован! Теперь можно вернуться на страницу авторизации и войти."),
              ]
            ),
          ),
        ),
      ],
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

  StepState _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.indexed;
    }
  }
  
  Widget _registrationFields() => Column(
    children: <Widget> [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: CupertinoTextField(
          textInputAction: TextInputAction.next,
          restorationId: 'email_address_text_field',
          placeholder: 'Email',
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
          placeholder: 'Пароль',
          keyboardType: TextInputType.visiblePassword,
          clearButtonMode: OverlayVisibilityMode.editing,
          autocorrect: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: CupertinoTextField(
          textInputAction: TextInputAction.next,
          restorationId: 'email_address_text_field',
          placeholder: 'Пароль (повтор)',
          keyboardType: TextInputType.visiblePassword,
          clearButtonMode: OverlayVisibilityMode.editing,
          autocorrect: false,
        ),
      ),
    ],
  );

  Widget _emailVerification() => Column(
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
  );

  //Поле с дополнительной информацией
  Widget _about() => Text('Presented by StarPony Inc. 2022');
}