import 'package:flutter/material.dart';
import '../../notification/notification_page.dart';
import '../home_page.dart'; // Wajib di-import agar logo bisa kembali ke Home

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = Theme.of(context).colorScheme.onSurface;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Sedikit melebarkan area pinggir
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- 1. ICON MENU KUSTOM (Hitbox Diperbesar) ---
            GestureDetector(
              // behavior: HitTestBehavior.opaque membuat seluruh area Container bisa diklik, 
              // bukan hanya pas di warna hitamnya saja.
              behavior: HitTestBehavior.opaque, 
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                padding: const EdgeInsets.all(10), // Padding ini memperbesar "area sentuh" (hitbox) jari
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Wrap(
                    spacing: 4, 
                    runSpacing: 4, 
                    children: List.generate(4, (index) => Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: iconColor, 
                        shape: BoxShape.circle,
                      ),
                    )),
                  ),
                ),
              ),
            ),
            
            // --- 2. LOGO APLIKASI BISA DIKLIK & DIPERBESAR ---
            GestureDetector(
              onTap: () {
                // Menghapus semua tumpukan halaman sebelumnya dan mereset paksa ke Home
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (_) => const HomePage()), 
                  (route) => false
                );
              },
              child: Image.asset(
                isDark ? 'assets/images/logo-putih.png' : 'assets/images/logo-hitam.png',
                height: 28, // Diperbesar dari sebelumnya 28 agar lebih ideal
                fit: BoxFit.contain,
              ),
            ),
            
            // --- 3. ICON NOTIFIKASI ---
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage())),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10), 
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF8F8F8), 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.notifications_none_rounded, 
                  size: 24, 
                  color: iconColor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70); 
}