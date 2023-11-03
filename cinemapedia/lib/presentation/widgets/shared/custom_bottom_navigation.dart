import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int selectedIndex = 0;

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        setState(() {
          selectedIndex = 0;
        });
        break;
      case 1:
        context.go('/');
        setState(() {
          selectedIndex = 1;
        });
        break;
      case 2:
        context.go('/favorites');
        setState(() {
          selectedIndex = 2;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: selectedIndex,
        elevation: 0,
        onTap: (value) => onItemTap(context, value),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categorias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_rounded), label: 'Favoritos'),
        ]);
  }
}
