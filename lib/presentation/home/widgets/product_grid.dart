import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, dynamic>> products = [
      {'name': 'Swift Glide Sprinter', 'price': '\$199', 'isFavorite': false},
      {'name': 'Echo Vibe Urban Runners', 'price': '\$149', 'isFavorite': true},
      {'name': 'Zen Dash Active Flex', 'price': '\$299', 'isFavorite': false},
      {'name': 'Nova Stride Street', 'price': '\$99', 'isFavorite': false},
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.65,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF8F8F8), 
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10, right: 10,
                      child: Icon(
                        product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: product['isFavorite'] ? Colors.red : Colors.grey.shade400, size: 20,
                      ),
                    ),
                    Center(child: Icon(Icons.snowshoeing, size: 80, color: isDark ? Colors.white24 : Colors.black26)), 
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(product['name'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Theme.of(context).colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product['price'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: isDark ? Colors.grey.shade800 : Colors.grey.shade200, shape: BoxShape.circle),
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