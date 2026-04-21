import 'package:flutter/material.dart';
import 'package:footflare/presentation/home/home_page.dart';
import 'package:footflare/presentation/order/cart_screen.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
// 1. TAMBAHKAN IMPORT INI
import 'package:footflare/presentation/profile/profile_page.dart';
import 'package:footflare/presentation/widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 2. UPDATE LIST HALAMAN DI SINI
  final List<Widget> _pages = [
    const HomePage(),
    const WishlistPage(),
    const CartScreen(),
    const Center(child: Text("Category")),
    const FootFlareProfile(), // <--- Ganti Text("Profile") menjadi ini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
