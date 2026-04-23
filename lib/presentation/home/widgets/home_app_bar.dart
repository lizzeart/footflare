import 'package:flutter/material.dart';
import '../../notification/notification_page.dart';
// PERUBAHAN 1: Import MainScreen, bukan HomePage
import '../../main_screen.dart'; 

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = Theme.of(context).colorScheme.onSurface;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- 1. ICON MENU KUSTOM ---
            GestureDetector(
              behavior: HitTestBehavior.opaque, 
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                padding: const EdgeInsets.all(10), 
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
            
            // --- 2. LOGO APLIKASI BISA DIKLIK ---
            GestureDetector(
              onTap: () {
                // PERUBAHAN 2: Arahkan ke MainScreen dengan initialIndex: 0 (Home)
                // Ini akan mereset halaman dan memunculkan kembali Bottom Nav Bar
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 0)), 
                  (route) => false
                );
              },
              child: Image.asset(
                isDark ? 'assets/images/logo-putih.png' : 'assets/images/logo-hitam.png',
                height: 26, 
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