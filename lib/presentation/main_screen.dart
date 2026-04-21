import 'package:flutter/material.dart';
import 'package:footflare/presentation/home/home_page.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
import 'package:footflare/presentation/widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // 0 untuk Home, 1 untuk Wishlist

  // List halaman yang akan dipanggil
  final List<Widget> _pages = [
    const HomePage(),
    const WishlistPage(),
    const Center(child: Text("Cart")),
    const Center(child: Text("Category")),
    const Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Menampilkan WishlistPage jika index = 1
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}