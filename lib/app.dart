import 'package:adm_boletos/components/button_text.dart';
import 'package:adm_boletos/components/colors.dart';
import 'package:adm_boletos/components/icons_app.dart';
import 'package:adm_boletos/components/leitor_codebar.dart';
import 'package:adm_boletos/screen_parts/app_bar.dart';
import 'package:adm_boletos/screen_parts/bottom_bar_screen.dart';
import 'package:adm_boletos/screen_parts/header_app.dart';
import 'package:adm_boletos/screen_parts/low_part_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 2;

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
                height: 710,
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        onCentralButtonPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: leitorQr(),
    );
  }
}
