import 'package:adm_boletos/Components/colors.dart';
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
                height: 750,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    spacing: 50,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Boletos a pagar!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                r'R$ 345.756,87',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'VER BOLETOS PAGOS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            child: Icon(
                              CupertinoIcons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 30,
                        children: [
                          Column(
                            spacing: 5,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [
                                        Color(0xff95f9c3),
                                        Color(0xff539c96),
                                        Color(0xff0c0b66),
                                      ],
                                      stops: [0, 0, 1],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    CupertinoIcons.money_dollar,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text('PAGAR', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          Column(
                            spacing: 5,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(
                                      colors: [
                                        Color(0xff95f9c3),
                                        Color(0xff539c96),
                                        Color(0xff0c0b66),
                                      ],
                                      stops: [0, 0, 1],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ).createShader(bounds);
                                  },
                                  child: Icon(
                                    CupertinoIcons.doc_text,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text('PAGOS', style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
