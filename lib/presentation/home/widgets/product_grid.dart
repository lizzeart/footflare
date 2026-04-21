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
      'name': 'Zen Dash Active Flex Shoes', // Nama diperbarui sesuai referensi
      'price': '\$299', 
      'isFavorite': false,
      'image': 'assets/images/pic3.png',
      'discount': '' 
    },
    {
      'name': 'Nova Stride Street Stompers', // Nama diperbarui sesuai referensi
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
        mainAxisSpacing: 24, // Jarak antar baris diperbesar agar muat 2 baris teks
        childAspectRatio: 0.58, // Rasio diubah agar kartu sedikit lebih tinggi
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
                    color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5), // Background kartu disamakan dengan referensi
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
                              // Logika warna merah muda/krimson untuk produk tertentu sesuai referensi
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
              
              // --- PERBAIKAN TEKS JUDUL (Max 2 Baris) ---
              Text(
                product['name'], 
                style: TextStyle(
                  fontFamily: 'Jost', 
                  fontWeight: FontWeight.w600, 
                  fontSize: 14, 
                  color: Theme.of(context).colorScheme.onSurface
                ), 
                maxLines: 2, // Memungkinkan teks turun ke baris kedua jika panjang
                overflow: TextOverflow.ellipsis
              ),
              const SizedBox(height: 8),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- PERBAIKAN HARGA (Lebih Bold) ---
                  Text(
                    product['price'], 
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold, 
                      fontSize: 18, // Diperbesar
                      color: Theme.of(context).colorScheme.onSurface
                    )
                  ),
                  
                  // --- PERBAIKAN KOTAK PANAH (Bukan Lingkaran) ---
                  Container(
                    padding: const EdgeInsets.all(6), // Padding agar ikon lega
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5), // Warna kotak panah
                      borderRadius: BorderRadius.circular(8), // Menggunakan lengkungan kotak, BUKAN shape circle
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