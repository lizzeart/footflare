import 'package:flutter/material.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    final brands = ['Nike', 'Adidas', 'Reebok', 'Puma', 'Bata'];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                    color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
                  ),
                  child: Icon(Icons.sports_esports, color: isDark ? Colors.white70 : Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(brands[index], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onSurface)),
              ],
            ),
          );
        },
      ),
    );
  }
}