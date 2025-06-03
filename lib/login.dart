import 'package:adm_boletos/Components/colors.dart';
import 'package:adm_boletos/Components/iniciar_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorFundoIcon(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StartButton(text: 'Iniciar', onPressed: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.person,color: Colors.white, size: 15,),
                  Text('Entrar em outra conta', style: TextStyle(color: Colors.white),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
