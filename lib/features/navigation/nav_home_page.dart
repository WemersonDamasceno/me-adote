import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../home/home_page.dart';
import '../profile/presentation/view/profile_view.dart';
import '../shop/presentation/views/product_list_view.dart';

class NavHomePage extends StatefulWidget {
  const NavHomePage({super.key});

  @override
  State<NavHomePage> createState() => _NavHomePageState();
}

class _NavHomePageState extends State<NavHomePage> {
  int _selectedIndex = 0;
  final widgetsPaginas = [
    const ProductListView(),
    const HomePage(),
    const Text(
      'Index 2: Notificacao',
    ),
    const ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: widgetsPaginas[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: kBottomNavigationBarHeight + 10,
        items: const [
          Icon(Icons.shopify_rounded, size: 30, color: Colors.white),
          Icon(Icons.pets, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        color: const Color(0xFFFFB228),
        buttonBackgroundColor: const Color(0xFFFFB228),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        letIndexChange: (index) => true,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
