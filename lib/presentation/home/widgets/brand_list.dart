import 'package:flutter/material.dart';

class BrandList extends StatelessWidget {
  const BrandList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, String>> brands = [
      {'name': 'Nike', 'image': 'assets/images/logo-nike.png'},
      {'name': 'Adidas', 'image': 'assets/images/logo-addidas.png'}, 
      {'name': 'Reebok', 'image': 'assets/images/logo-reebok.png'},
      {'name': 'Puma', 'image': 'assets/images/logo-puma.png'},
      {'name': 'Bata', 'image': 'assets/images/logo-bata.png'},
    ];

    return SizedBox(
      height: 100, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                Container(
                  width: 60, 
                  height: 60, 
                  padding: const EdgeInsets.all(14), 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Garis tepi disesuaikan di mode malam agar lingkarannya menonjol
                    border: Border.all(color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                    // KUNCI: Selalu gunakan warna putih untuk background lingkaran
                    color: Colors.white, 
                  ),
                  child: Image.asset(
                    brands[index]['image']!,
                    fit: BoxFit.contain, 
                    // Karena background lingkarannya putih, biarkan logo brand aslinya 
                    // (yang berwarna hitam) tampil apa adanya tanpa diubah warnanya.
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  brands[index]['name']!, 
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.w500, 
                    color: Theme.of(context).colorScheme.onSurface
                  )
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}