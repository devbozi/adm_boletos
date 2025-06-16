import 'package:adm_boletos/components/button_text.dart';
import 'package:adm_boletos/components/colors.dart';
import 'package:adm_boletos/components/header_app.dart';
import 'package:adm_boletos/components/icons_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.bell, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.eye_slash, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.bars, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 30,
                        children: [
                          IconsApp(icon: CupertinoIcons.money_dollar),
                          IconsApp(icon: CupertinoIcons.doc_text),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonText(text: 'A PAGAR'),
                        ButtonText(text: 'TOTAL PAGOS'),
                        ButtonText(text: 'VENCIDOS'),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Text(
                                      'Total pago esse mes',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      r'R$ 23.123,49',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff95f9c3),
                                      Color(0xff539c96),
                                      Color(0xff0c0b66),
                                    ],
                                    stops: [0, 0, 1],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text('Mais detalhes'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
