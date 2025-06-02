import 'package:adm_boletos/Components/icons.dart';
import 'package:adm_boletos/Components/options_bars.dart';
import 'package:adm_boletos/Components/selection_boletos.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        leading: CustomCupertinoIcon(),
      ),
      body: Column( 
        children: [
          OptionsBars(text: "Vencidos"),
          BoletosMenu(),
        ],
      ),
    );
  }
}