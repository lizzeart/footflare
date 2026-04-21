import 'package:flutter/material.dart';

class WishlistCard extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  final String discount;
  final Color discountBg;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const WishlistCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.onRemove,
    required this.onTap,
    this.discount = "",
    this.discountBg = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. ASPEK RATIO FOTO (Mencegah distorsi di layar lebar)
        AspectRatio(
          aspectRatio: 3 / 4, // Mengunci rasio 3:4
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(image, fit: BoxFit.contain),
                  ),
                ),
              ),
              // Banner Diskon Vertikal
              if (discount.isNotEmpty)
                Positioned(
                  top: 0,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    decoration: BoxDecoration(
                      color: discountBg,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        discount,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              // Tombol Wishlist (Love)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.favorite, color: Colors.red, size: 22),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 2. TEKS NAMA PRODUK
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // 3. HARGA & BUTTON DETAIL (Dengan Padding agar tidak terlalu ke kanan)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${price.toInt()}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // Button Detail dengan margin kanan
            Padding(
              padding: const EdgeInsets.only(right: 4.0), // Mencegah terlalu mepet
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, size: 16, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}