import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white, // Frame dibuat konsisten selalu putih
        border: Border(top: BorderSide(color: Colors.grey.shade200)), // Garis batas atas yang tipis
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 'assets/images/nav-home.png', isActive: true),
            _buildNavItem(context, 'assets/images/nav-wishlist.png'),
            _buildNavItem(context, 'assets/images/nav-mycart.png'),
            _buildNavItem(context, 'assets/images/nav-category.png'),
            _buildNavItem(context, 'assets/images/nav-profile.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String imagePath, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          width: 24,  
          height: 24,
          // Icon akan selalu tampil solid hitam penuh (100% opacity), 
          // tidak peduli sedang diklik atau tidak.
          color: Colors.black, 
        ),
        
        // Garis indikator ini yang sekarang menjadi satu-satunya penanda menu aktif
        if (isActive)
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 3,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.black, 
              borderRadius: BorderRadius.circular(2),
            ),
          )
      ],
    );
  }
}