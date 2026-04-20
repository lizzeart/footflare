import 'package:flutter/material.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Swift Glide Sprinter', 
      'price': '\$199', 
      'isFavorite': false,
      'image': 'assets/images/pic1.png',
      'discount': '30% OFF'
    },
    {
      'name': 'Echo Vibe Urban Runners', 
      'price': '\$149', 
      'isFavorite': true,
      'image': 'assets/images/pic2.png',
      'discount': '' 
    },
    {
      'name': 'Zen Dash Active Flex', 
      'price': '\$299', 
      'isFavorite': false,
      'image': 'assets/images/pic3.png',
      'discount': '' 
    },
    {
      'name': 'Nova Stride Street', 
      'price': '\$99', 
      'isFavorite': false,
      'image': 'assets/images/pic4.png',
      'discount': '30% OFF'
    },
    {
      'name': 'Aero Glide Pro', 
      'price': '\$129', 
      'isFavorite': false,
      'image': 'assets/images/pic5.png',
      'discount': '30% OFF'
    },
    {
      'name': 'Urban Kicks Classic', 
      'price': '\$89', 
      'isFavorite': true,
      'image': 'assets/images/pic6.png',
      'discount': '20% OFF'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 16, 
        mainAxisSpacing: 16, 
        childAspectRatio: 0.65,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF8F8F8), 
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  children: [
                    // --- GAMBAR MEMENUHI FRAME ---
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          product['image'],
                          fit: BoxFit.cover, // Gambar akan memenuhi seluruh area kotak
                        ),
                      ),
                    ), 
                    
                    // Banner Diskon Vertikal
                    if (product['discount'] != null && product['discount'].toString().isNotEmpty)
                      Positioned(
                        top: 0,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                          decoration: BoxDecoration(
                            color: product['discount'].contains('30%') ? Colors.black : const Color(0xFFC70039),
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          ),
                          child: RotatedBox(
                            quarterTurns: 3, 
                            child: Text(
                              product['discount'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost',
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    
                    // Tombol Favorit
                    Positioned(
                      top: 10, right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _products[index]['isFavorite'] = !_products[index]['isFavorite'];
                          });
                        },
                        child: Icon(
                          product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                          color: product['isFavorite'] ? Colors.red : Colors.grey.shade400, 
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Nama Produk menggunakan Jost Medium (w500)
            Text(
              product['name'], 
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.w500, // Menarik file Jost-Medium.ttf
                fontSize: 14, 
                color: Theme.of(context).colorScheme.onSurface,
              ), 
              maxLines: 1, 
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['price'], 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 16, 
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, 
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward, size: 16, color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            )
          ],
        );
      },
    );
  }
}