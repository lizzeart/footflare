import 'package:flutter/material.dart';
import '../../models/product_models.dart';
import 'package:footflare/presentation/wishlist/widgets/wishlist_card.dart';
import 'package:footflare/presentation/search/search_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  // Data Produk [cite: 11, 53, 67]
  List<Product> products = [
    Product(id: '1', name: 'Swift Glide Sprinter Soles', price: 199, image: 'assets/images/pic1.png', discount: '30% OFF', discountColor: Colors.black, isWishlist: true),
    Product(id: '2', name: 'Echo Vibe Urban Runners', price: 149, image: 'assets/images/pic2.png', isWishlist: true),
    Product(id: '3', name: 'Zen Dash Active Flex Shoes', price: 299, image: 'assets/images/pic3.png', isWishlist: true),
    Product(id: '4', name: 'Nova Stride Street Stopers', price: 99, image: 'assets/images/pic4.png', discount: '30% OFF', discountColor: Colors.red, isWishlist: true),
    Product(id: '5', name: 'Evo Quip Evo Quick Strides', price: 199, image: 'assets/images/pic5.png', discount: '30% OFF', discountColor: Colors.black, isWishlist: true),
    Product(id: '6', name: 'Echo Vibe Urban Runners', price: 84, image: 'assets/images/pic6.png', discount: '20% OFF', discountColor: Colors.red, isWishlist: true),
  ];

  List<String> categories = ["All", "Child", "Man", "Woman", "Unisex"]; // [cite: 41, 59]
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    List<Product> wishlistItems = products.where((p) => p.isWishlist).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildHeaderIcon(Icons.arrow_back_ios_new, () => Navigator.pop(context), size: 16),
        title: const Text("Wishlist", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
          _buildCategoryBar(),
          Expanded(
            child: wishlistItems.isEmpty 
            ? const Center(child: Text("Wishlist kamu kosong"))
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
                    onTap: () => debugPrint("Navigasi ke detail: ${product.name}"),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap, {double size = 20}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(8)),
        child: IconButton(icon: Icon(icon, color: Colors.black, size: size), onPressed: onTap),
      ),
    );
  }

  Widget _buildCategoryBar() {
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
                color: isSelected ? Colors.black : const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(categories[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
              ),
            ),
          );
        },
      ),
    );
  }
}