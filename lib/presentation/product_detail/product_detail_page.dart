import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedThumbnailIndex = 0;

  final List<String> _sizes = ['6.5', '7', '7.5', '8', '8.5', '9', '9.5'];
  
  final List<Color> _colors = [
    Colors.transparent, 
    const Color(0xFF5C71D4),
    const Color(0xFFD4A05C),
    const Color(0xFF9E9E9E),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = Theme.of(context).colorScheme.onSurface;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context, isDark, iconColor),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN GAMBAR UTAMA & THUMBNAIL ---
            _buildImageGallery(isDark),
            
            // --- INFORMASI PRODUK ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name'],
                    style: TextStyle(fontFamily: 'Jost', fontSize: 22, fontWeight: FontWeight.bold, color: iconColor),
                  ),
                  const SizedBox(height: 20),
                  
                  Text('Items Size:', style: TextStyle(fontFamily: 'Jost', fontSize: 14, fontWeight: FontWeight.w600, color: iconColor)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(_sizes.length, (index) {
                      final isSelected = _selectedSizeIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSizeIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 45,
                          height: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? (isDark ? Colors.white : Colors.black) 
                                : (isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF5F5F5)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _sizes[index],
                            style: TextStyle(
                              fontFamily: 'Jost',
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              color: isSelected 
                                  ? (isDark ? Colors.black : Colors.white) 
                                  : (isDark ? Colors.white70 : Colors.black87),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 25),
                  
                  Text('Description:', style: TextStyle(fontFamily: 'Jost', fontSize: 14, fontWeight: FontWeight.w600, color: iconColor)),
                  const SizedBox(height: 8),
                  Text(
                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humor.',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 13, color: Colors.grey.shade600, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade200)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product['price'],
                style: TextStyle(fontFamily: 'Jost', fontSize: 24, fontWeight: FontWeight.bold, color: iconColor),
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFEBEBEB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.favorite, color: isDark ? Colors.grey : Colors.black, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: isDark ? Colors.black : Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Add To Cart',
                          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600, color: isDark ? Colors.black : Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isDark, Color iconColor) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2D3A) : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.arrow_back_ios_new, size: 16, color: iconColor),
          ),
        ),
      ),
      title: Text('Product Details', style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w600, fontSize: 16, color: iconColor)),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            decoration: BoxDecoration(color: isDark ? const Color(0xFF2A2D3A) : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.shopping_cart_outlined, size: 18, color: iconColor),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildImageGallery(bool isDark) {
    final List<String> thumbnails = [
      widget.product['image'], 'assets/images/pic2.png', 'assets/images/pic3.png', 'assets/images/pic4.png'
    ];

    return Container(
      width: double.infinity,
      height: 420,
      color: isDark ? const Color(0xFF1B1D27) : const Color(0xFFF3F3F3),
      child: Stack(
        children: [
          // --- PERUBAHAN UTAMA: GAMBAR FULL FRAME TANPA PADDING ---
          Positioned.fill(
            child: Image.asset(
              thumbnails[_selectedThumbnailIndex], 
              fit: BoxFit.cover, // Ini akan memaksa gambar merentang menutupi seluruh area tanpa sisa margin
            ),
          ),

          // Pilihan Warna (Kiri Atas)
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              children: List.generate(_colors.length, (index) {
                final isSelected = _selectedColorIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColorIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: 24, height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 1.5),
                    ),
                    child: Center(
                      child: Container(
                        width: 18, height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _colors[index] == Colors.transparent ? const Color(0xFFDCDCDC) : _colors[index], 
                        ),
                        child: isSelected && index == 0 ? const Icon(Icons.check, size: 12, color: Colors.black) : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Thumbnail Bawah
          Positioned(
            bottom: 20,
            left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(thumbnails.length, (index) {
                final isSelected = _selectedThumbnailIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedThumbnailIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isSelected ? const Color(0xFFC70039) : Colors.transparent, width: 1.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(thumbnails[index], fit: BoxFit.contain),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}