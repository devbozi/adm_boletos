import 'package:adm_boletos/screens/barcode_scanner_screen.dart';
import 'package:adm_boletos/screens/extract_screen.dart';
import 'package:adm_boletos/screens/graphic_screen.dart';
import 'package:adm_boletos/screens/home_screen.dart';
import 'package:adm_boletos/screens/person_screen.dart';
import 'package:adm_boletos/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  bool _centralButtonActive = false;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    GraphicScreen(),
    ExtractScreen(),
    PersonScreen(),
  ];

  void _handleItemTapped(int index, BuildContext context) {
    if (index == 2) {
      // Botão central → abre tela com animação
      _handleCentralButtonPressed(context);
    } else {
      final adjustedIndex = index > 2 ? index - 1 : index;
      setState(() {
        _selectedIndex = adjustedIndex;
      });
    }
  }

  void _handleCentralButtonPressed(BuildContext context) {
    setState(() {
      _centralButtonActive = true;
    });
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const BarcodeScannerScreen(),
        transitionsBuilder: (_, animation, __, child) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    ).then((_) {
      setState(() {
        _centralButtonActive = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        currentIndex: _selectedIndex,
        centralButtonActive: _centralButtonActive,
        onItemTapped: (index) => _handleItemTapped(index, context),
        onCentralButtonPressed: () => _handleCentralButtonPressed(context),
      ),
    );
  }
}
