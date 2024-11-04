import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';

class NavHomePage extends StatefulWidget {
  const NavHomePage({super.key});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  int _selectedIndex = 0;
  final widgetsPaginas = [
    const HomePage(),
    const Text(
      'Index 1: Favoritos',
    ),
    const Text(
      'Index 2: Notificacao',
    ),
    const Text(
      'Index 3: Busca',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: widgetsPaginas[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: size.height * 0.08,
        items: const [
          Icon(Icons.home_rounded, size: 30, color: Colors.white),
          Icon(Icons.favorite_rounded, size: 30, color: Colors.white),
          Icon(Icons.search_rounded, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: const Color(0xFFFFB228),
        buttonBackgroundColor: const Color(0xFFFFB228),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {
          _onItemTapped(index);
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
