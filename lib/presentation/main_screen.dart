import 'package:flutter/material.dart';
import 'package:footflare/presentation/home/home_page.dart';
import 'package:footflare/presentation/order/cart_screen.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
import 'package:footflare/presentation/profile/profile_page.dart';
import 'package:footflare/presentation/widgets/custom_bottom_nav.dart';
import 'package:footflare/presentation/category/category_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const HomePage(),
    const WishlistPage(),
    const CartScreen(),
    const CategoryPage(),
    const FootFlareProfile(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}