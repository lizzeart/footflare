import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductActionSheet {
  static const Color softColor = Color(0xFFF6F6F6);

  /// =====================================================
  /// BOTTOM MENU BAR
  /// =====================================================
  static Widget bottomMenu({
    required VoidCallback onGenderTap,
    required VoidCallback onSortTap,
    required VoidCallback onFilterTap,
  }) {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          _BottomMenuBtn(
            icon: "assets/icon/gander.svg",
            text: "GENDER",
            onTap: onGenderTap,
          ),
          // Garis Pemisah 1
          _divider(),
          _BottomMenuBtn(
            icon: "assets/icon/sort.svg",
            text: "SORT",
            onTap: onSortTap,
          ),
          // Garis Pemisah 2
          _divider(),
          _BottomMenuBtn(
            icon: "assets/icon/filter.svg",
            text: "FILTER",
            onTap: onFilterTap,
          ),
        ],
      ),
    );
  }

  /// Widget pembantu untuk garis pemisah vertikal
  static Widget _divider() {
    return Container(
      height: 24, // Tinggi garis agar tidak menyentuh atas-bawah
      width: 1,
      color: Colors.black12,
    );
  }
}

/// =====================================================
/// COMPONENT: BOTTOM MENU BUTTON (With Hover & Larger Font)
/// =====================================================
class _BottomMenuBtn extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const _BottomMenuBtn({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        // Menambahkan warna saat kursor berada di atas tombol (Hover)
        hoverColor: Colors.black.withOpacity(0.05),
        splashColor: Colors.black.withOpacity(0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 18, // Sedikit diperbesar agar proporsional
              height: 18,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Jost',
                fontSize: 14, // Diperbesar dari 13 ke 14
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================================
/// COMPONENT: CHIP BUTTON (Untuk Gender & Sort)
/// =====================================================
class ActionChipBtn extends StatelessWidget {
  final String text;
  final bool active;
  final VoidCallback onTap;

  const ActionChipBtn({
    super.key,
    required this.text,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: active ? Colors.black : ProductActionSheet.softColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Jost',
            fontSize: 14, // Disamakan menjadi 14
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

/// =====================================================
/// COMPONENT: MENU BOX (Untuk Filter)
/// =====================================================
class ActionMenuBox extends StatelessWidget {
  final String text;

  const ActionMenuBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: ProductActionSheet.softColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Jost',
          fontSize: 14, // Disamakan menjadi 14
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}