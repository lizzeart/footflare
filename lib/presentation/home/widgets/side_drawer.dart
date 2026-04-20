import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../main.dart'; 

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        // Menggunakan SizedBox untuk merampingkan ukuran kotak drawer/bar ke kiri
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.72, // Sekitar 72% dari lebar layar
          child: Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1B1D27) : Colors.white,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileHeader(context, isDark),
                    Divider(color: isDark ? Colors.white10 : Colors.grey.shade200, thickness: 1, height: 1),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(height: 10), // Sedikit jarak setelah garis pembatas
                          _buildMenuItem(context, Icons.home_outlined, 'Home'),
                          _buildMenuItem(context, Icons.shopping_bag_outlined, 'Products'),
                          _buildMenuItem(context, Icons.grid_view_outlined, 'Components'),
                          _buildMenuItem(context, Icons.diamond_outlined, 'Pages'),
                          _buildMenuItem(context, Icons.star_border_outlined, 'Featured'),
                          _buildMenuItem(context, Icons.favorite_border, 'Wishlist'),
                          _buildMenuItem(context, Icons.receipt_long_outlined, 'Orders'),
                          _buildMenuItem(context, Icons.chat_bubble_outline, 'Chat List'),
                          _buildMenuItem(context, Icons.shopping_cart_outlined, 'My Cart'),
                          _buildMenuItem(context, Icons.person_outline, 'Profile'),
                          _buildMenuItem(context, Icons.logout, 'Logout'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'FootFlare Shoe Store\nApp Version 1.0', 
                        style: TextStyle(color: isDark ? Colors.grey.shade500 : Colors.grey, fontSize: 12)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Memastikan avatar sejajar atas
        children: [
          // --- FOTO PROFIL ASLI ---
          const CircleAvatar(
            radius: 25, 
            backgroundColor: Colors.transparent, // Hapus warna abu-abu
            backgroundImage: AssetImage('assets/images/profil.png'), // Mengambil gambar profil.png
          ),
          const SizedBox(width: 15),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris ini menempatkan Nama dan Toggle sejajar di bagian atas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Amelia', 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    ),
                    
                    // --- TOGGLE TEMA DENGAN BACKGROUND KEHIJAUAN ---
                    ValueListenableBuilder<ThemeMode>(
                      valueListenable: themeNotifier,
                      builder: (context, currentMode, child) {
                        return GestureDetector(
                          onTap: () => themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                              // Warna hijau lembut di mode siang, abu-abu gelap di mode malam
                              color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFE4EDE7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.wb_sunny_outlined, size: 18, color: isDark ? Colors.grey : Colors.black),
                                const SizedBox(width: 8),
                                Icon(Icons.nightlight_round, size: 18, color: isDark ? Colors.white : Colors.grey),
                              ],
                            ),
                          ),
                        );
                      }
                    )
                  ],
                ),
                
                const SizedBox(height: 2), // Jarak tipis antara nama dan email
                
                // --- TEKS EMAIL ---
                // Karena toggle sudah dipindah ke atas, email sekarang bisa memanjang tanpa terpotong
                Text(
                  'example@gmail.com', 
                  style: TextStyle(
                    fontSize: 14, 
                    color: Colors.grey.shade600
                  ),
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

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 24),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.w500, 
          color: Theme.of(context).colorScheme.onSurface
        )
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
      dense: true,
      visualDensity: const VisualDensity(vertical: -2), // Merapatkan jarak antar menu
    );
  }
}