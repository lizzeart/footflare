import 'package:flutter/material.dart';
import '../../notification/notification_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = Theme.of(context).colorScheme.onSurface;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // Menggunakan Stack agar Logo bisa persis di tengah (center) mutlak
        child: Stack(
          alignment: Alignment.center,
          children: [
            
            // --- KIRI: ICON MENU KUSTOM (4 Titik) ---
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
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
            
            // --- TENGAH: LOGO APLIKASI (Diperkecil & Center) ---
            Image.asset(
              isDark ? 'assets/images/logo-putih.png' : 'assets/images/logo-hitam.png',
              height: 20, // Ukuran diperkecil dari 28 menjadi 20 agar lebih proporsional
              fit: BoxFit.contain,
            ),
            
            // --- KANAN: ICON NOTIFIKASI ---
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage())),
                child: Container(
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
            ),

          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70); 
}