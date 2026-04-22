import 'package:flutter/material.dart';
import '../../product_detail/product_detail_page.dart';

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
      'isFavorite': false,
      'image': 'assets/images/pic2.png',
      'discount': '' 
    },
    {
      'name': 'Zen Dash Active Flex Shoes', 
      'price': '\$299', 
      'isFavorite': false,
      'image': 'assets/images/pic3.png',
      'discount': '' 
    },
    {
      'name': 'Nova Stride Street Stompers', 
      'price': '\$99', 
      'isFavorite': false,
      'image': 'assets/images/pic4.png',
      'discount': '30% OFF'
    },
    {
      'name': 'Evo Quip Evo Quick Strides', 
      'price': '\$199', 
      'isFavorite': false,
      'image': 'assets/images/pic5.png',
      'discount': '30% OFF'
    },
    {
      'name': 'Echo Vibe Urban Runners', 
      'price': '\$84', 
      'isFavorite': false,
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
        mainAxisSpacing: 24, 
        childAspectRatio: 0.58, 
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)
              )
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white, // Kotak gambar tetap putih mutlak
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16), 
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ), 
                      
                      if (product['discount'] != null && product['discount'].toString().isNotEmpty)
                        Positioned(
                          top: 0, 
                          left: 16, 
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                            decoration: BoxDecoration(
                              color: product['name'].toString().contains('Nova') || product['discount'].toString().contains('20%')
                                  ? const Color(0xFFC70039) 
                                  : Colors.black,
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(100)),
                            ),
                            child: RotatedBox(
                              quarterTurns: 3, 
                              child: Text(
                                product['discount'],
                                style: const TextStyle(
                                  color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Jost', letterSpacing: 1.0, 
                                ),
                              ),
                            ),
                          ),
                        ),
                      
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
                            color: product['isFavorite'] ? const Color(0xFFC70039) : Colors.grey.shade400, 
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // --- PERBAIKAN: Kunci tinggi teks agar harga di bawahnya sejajar ---
              SizedBox(
                height: 40, // Tinggi tetap (ideal untuk 2 baris teks)
                child: Text(
                  product['name'], 
                  style: TextStyle(
                    fontFamily: 'Jost', 
                    fontWeight: FontWeight.w600, 
                    fontSize: 14, 
                    color: Theme.of(context).colorScheme.onSurface
                  ), 
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis
                ),
              ),
              const SizedBox(height: 8),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product['price'], 
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold, 
                      fontSize: 18, 
                      color: Theme.of(context).colorScheme.onSurface
                    )
                  ),
                  
                  Container(
                    padding: const EdgeInsets.all(6), 
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5), 
                      borderRadius: BorderRadius.circular(8), 
                    ),
                    child: Icon(
                      Icons.arrow_forward, 
                      size: 18, 
                      color: Theme.of(context).colorScheme.onSurface
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}