import 'package:flutter/material.dart';
import '../../models/product_models.dart';
import 'package:footflare/presentation/wishlist/widgets/wishlist_card.dart';
import 'package:footflare/presentation/search/search_page.dart';
import 'package:footflare/presentation/product_detail/product_detail_page.dart';

// 1. UBAH IMPORT KE MAIN SCREEN
import 'package:footflare/presentation/main_screen.dart'; 

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Product> products = [
    Product(id: '1', name: 'Swift Glide Sprinter Soles', price: 199, image: 'assets/images/pic1.png', discount: '30% OFF', discountColor: Colors.black, isWishlist: true),
    Product(id: '2', name: 'Echo Vibe Urban Runners', price: 149, image: 'assets/images/pic2.png', isWishlist: true),
    Product(id: '3', name: 'Zen Dash Active Flex Shoes', price: 299, image: 'assets/images/pic3.png', isWishlist: true),
    Product(id: '4', name: 'Nova Stride Street Stopers', price: 99, image: 'assets/images/pic4.png', discount: '30% OFF', discountColor: Colors.red, isWishlist: true),
    Product(id: '5', name: 'Evo Quip Evo Quick Strides', price: 199, image: 'assets/images/pic5.png', discount: '30% OFF', discountColor: Colors.black, isWishlist: true),
    Product(id: '6', name: 'Urban Kicks Classic', price: 84, image: 'assets/images/pic6.png', discount: '20% OFF', discountColor: Colors.red, isWishlist: true),
  ];

  List<String> categories = ["All", "Child", "Man", "Woman", "Unisex"];
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    List<Product> wishlistItems = products.where((p) => p.isWishlist).toList();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        
        leading: _buildHeaderIcon(
          Icons.arrow_back_ios_new,
          () {
            // 2. PERBAIKAN LOGIKA BACK:
            // Gunakan pushAndRemoveUntil menuju MainScreen agar Bottom Nav muncul 
            // dan tumpukan halaman sebelumnya dibersihkan
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          },
          size: 16
        ),
        
        title: Text(
          "Wishlist",
          style: TextStyle(
            color: colorScheme.onSurface, 
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          _buildHeaderIcon(Icons.search, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
          }),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryBar(isDark, colorScheme),

          Expanded(
            child: wishlistItems.isEmpty
            ? Center(child: Text("Wishlist kamu kosong", style: TextStyle(color: colorScheme.onSurface)))
            : GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                ),
                itemCount: wishlistItems.length,
                itemBuilder: (context, index) {
                  final product = wishlistItems[index];
                  return WishlistCard(
                    name: product.name,
                    image: product.image,
                    price: product.price,
                    discount: product.discount,
                    discountBg: product.discountColor ?? Colors.black,
                    onRemove: () => setState(() => product.isWishlist = false),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: {
                              'name': product.name,
                              'image': product.image,
                              'price': product.price.toString(),
                              'discount': product.discount,
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap, {double size = 20}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.1) : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: size),
          onPressed: onTap,
        ),
      ),
    );
  }

  Widget _buildCategoryBar(bool isDark, ColorScheme colorScheme) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: isSelected ? colorScheme.primary : (isDark ? Colors.white10 : const Color(0xFFF2F2F2)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? (isDark ? Colors.black : Colors.white) : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}