import 'package:adm_boletos/components/button_text.dart';
import 'package:adm_boletos/components/colors.dart';
import 'package:adm_boletos/components/icons_app.dart';
import 'package:adm_boletos/screen_parts/app_bar.dart';
import 'package:adm_boletos/screen_parts/header_app.dart';
import 'package:adm_boletos/screen_parts/low_part_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarScreen(context),
      body: Center(
        child: ColorFundoIcon(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                height: 780,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  spacing: 20,
                  children: [
                    Padding(padding: const EdgeInsets.all(30), child: Header()),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: IconsScreen(),
                    ),
                    TextsButtonsScreen(),
                    LowPartApp(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}