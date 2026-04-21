import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:footflare/main.dart';
import 'package:footflare/presentation/auth/splash_screen.dart';

// --- Import Halaman MainScreen untuk navigasi ---
// Pastikan path ini sesuai dengan lokasi file MainScreen kamu
import 'package:footflare/presentation/main_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.72,
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1B1D27) : Colors.white,
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Profil (Bisa diklik untuk ke profil)
                    InkWell(
                      onTap: () =>
                          _navigateToPage(context, 4), // Index 4 adalah Profil
                      child: _buildProfileHeader(context, isDark),
                    ),
                    Divider(
                      color: isDark ? Colors.white10 : Colors.grey.shade200,
                      thickness: 1,
                      height: 1,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 10),
                          _buildMenuItem(
                            context,
                            Icons.home_outlined,
                            'Home',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.shopping_bag_outlined,
                            'Products',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.grid_view_outlined,
                            'Components',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.diamond_outlined,
                            'Pages',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.star_border_outlined,
                            'Featured',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.favorite_border,
                            'Wishlist',
                            1,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.receipt_long_outlined,
                            'Orders',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.chat_bubble_outline,
                            'Chat List',
                            0,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.shopping_cart_outlined,
                            'My Cart',
                            2,
                          ),
                          _buildMenuItem(
                            context,
                            Icons.person_outline,
                            'Profile',
                            4,
                          ),
                          _buildMenuItem(context, Icons.logout, 'Logout', -1),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'FootFlare Shoe Store\nApp Version 1.0',
                        style: TextStyle(
                          color: isDark ? Colors.grey.shade500 : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi helper untuk navigasi agar Nav Bar tetap ada
  void _navigateToPage(BuildContext context, int index) {
    Navigator.pop(context); // Tutup drawer

    // 1. CEK JIKA INDEX ADALAH LOGOUT (-1)
    if (index == -1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ), // Kembali ke awal
        (route) => false, // Hapus semua riwayat halaman
      );
      return;
    }

    // 2. LOGIKA NAVIGASI BIASA KE HALAMAN LAIN
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(initialIndex: index)),
      (route) => false,
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            backgroundImage: AssetImage('assets/images/profil.png'),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amelia',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    // Tombol Dark Mode
                    ValueListenableBuilder<ThemeMode>(
                      valueListenable: themeNotifier,
                      builder: (context, currentMode, child) {
                        return GestureDetector(
                          onTap: () => themeNotifier.value = isDark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF2A2D3A)
                                  : const Color(0xFFE4EDE7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 18,
                                  color: isDark ? Colors.grey : Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.nightlight_round,
                                  size: 18,
                                  color: isDark ? Colors.white : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  'example@gmail.com',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    int targetIndex,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurface,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () => _navigateToPage(context, targetIndex),
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
    );
  }
}
