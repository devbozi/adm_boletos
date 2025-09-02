import 'package:adm_boletos/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'package:intl/date_symbol_data_local.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('pt_br', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'ADM Boletos',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
      navigatorObservers: [routeObserver],
    );
  }
}
