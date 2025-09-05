import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final int currentIndex;
  final bool centralButtonActive;
  final Function(int) onItemTapped;
  final VoidCallback onCentralButtonPressed;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.currentIndex,
    required this.onItemTapped,
    required this.onCentralButtonPressed,
    required this.centralButtonActive,
  });
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIcon(Icons.home, 0),
            _buildIcon(Icons.bar_chart, 1),
            _buildCentralButton(2, context),
            _buildIcon(Icons.description, 3),
            _buildIcon(Icons.person, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index) {
    final int realIndex = index > 2 ? index - 1 : index;
    final bool isSelected = widget.selectedIndex == realIndex;

    return GestureDetector(
      onTap: () => widget.onItemTapped(index),
      child: AnimatedScale(
        scale: isSelected ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Icon(
          icon,
          color: isSelected ? const Color(0xff539c96) : Colors.black,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildCentralButton(int index, BuildContext context) {
    final isActive = widget.centralButtonActive;
    return GestureDetector(
      onTap: widget.onCentralButtonPressed,
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              isActive
                  ? const LinearGradient(
                    colors: [Color(0xff0c0b66), Color(0xff539c96)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : const LinearGradient(
                    colors: [
                      Color(0xff95f9c3),
                      Color(0xff539c96),
                      Color(0xff0c0b66),
                    ],
                    stops: [0, 0, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
