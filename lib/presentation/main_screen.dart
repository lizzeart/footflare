import 'package:flutter/material.dart';
import 'package:footflare/presentation/home/home_page.dart';
import 'package:footflare/presentation/order/cart_screen.dart';
import 'package:footflare/presentation/wishlist/wishlist_page.dart';
// Import halaman profil kamu
import 'package:footflare/presentation/profile/profile_page.dart'; 
import 'package:footflare/presentation/widgets/custom_bottom_nav.dart';
import 'package:footflare/presentation/home/widgets/side_drawer.dart';

class MainScreen extends StatefulWidget {
  // Tambahkan parameter initialIndex agar SideDrawer bisa menentukan halaman mana yang dibuka
  final int initialIndex; 
  
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  // List halaman yang terintegrasi dengan Bottom Navigation Bar
  final List<Widget> _pages = [
    const HomePage(),           // Index 0
    const WishlistPage(),       // Index 1
    const CartScreen(),         // Index 2
    const Center(child: Text("Category")), // Index 3 (Opsional)
    const FootFlareProfile(),   // Index 4: Halaman Profil Amelia
  ];

  @override
  void initState() {
    super.initState();
    // Mengeset index awal berdasarkan parameter yang dikirim (default 0)
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Pasang SideDrawer di sini agar bisa diakses dari semua tab
      drawer: const SideDrawer(), 
      
      // Menggunakan IndexedStack agar state halaman (seperti scroll) tidak hilang saat pindah tab
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      
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