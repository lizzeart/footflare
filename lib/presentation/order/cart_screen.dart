import 'package:flutter/material.dart';
import 'widgets/cart_item_card.dart';
import 'checkout_screen.dart';
import 'package:footflare/presentation/main_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> cartItems = [
    {
      "name": "Echo Vibe Urban Runners",
      "price": 179,
      "qty": 1,
      "image": "assets/images/pic6.png", // Sesuaikan nama filenya
    },
    {
      "name": "Swift Glide Sprinter Soles",
      "price": 199,
      "qty": 1,
      "image": "assets/images/pic2.png",
    },
    {
      "name": "Zen Dash Active Flex Shoes",
      "price": 150,
      "qty": 1,
      "image": "assets/images/pic3.png",
    },
  ];

  void _removeItem(int index) {
    final removedItem = cartItems[index]; // Capture data sebelum dihapus

    _listKey.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: CartItemCard(
            // Gunakan data dari removedItem yang sudah di-capture
            name: removedItem['name'],
            price: "\$${removedItem['price']}",
            imagePath: removedItem['image'],
            quantity: removedItem['qty'],
            onAdd: () {},
            onRemove: () {},
            onDelete: () {},
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );

    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int subtotal = cartItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty'] as int),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      initialIndex: 0,
                    ),
                  ),
                  (route) => false,
                );                
              },              
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              ),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              width: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    children: [
                      const TextSpan(text: "Subtotal "),
                      TextSpan(
                        text: "\$$subtotal",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Your order is eligible for free Delivery",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: cartItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // Di dalam AnimatedList -> itemBuilder
              itemBuilder: (context, index, animation) {
                final item = cartItems[index];

                return CartItemCard(
                  // TAMBAHKAN KEY DI SINI
                  // ValueKey menggunakan nama atau ID unik agar Flutter bisa melacak widget ini
                  key: ValueKey(item['name']),

                  name: item['name'],
                  price: "\$${item['price']}",
                  imagePath: item['image'],
                  quantity: item['qty'],
                  onAdd: () => setState(() => item['qty']++),
                  onRemove: () => setState(() {
                    if (item['qty'] > 1) item['qty']--;
                  }),
                  onDelete: () => _removeItem(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton(
                onPressed: () {
                  // PERBAIKAN: Menggunakan PageRouteBuilder agar transisi instan
                  // dan mengirim parameter 'items' ke CheckoutScreen
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          CheckoutScreen(items: cartItems),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                style:
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 60),
                      elevation: 0, // Menghilangkan shadow sesuai permintaanmu
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // Menghilangkan efek abu-abu saat kursor diarahkan ke tombol
                      enabledMouseCursor: SystemMouseCursors.click,
                    ).copyWith(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                    ),
                child: Text(
                  "Proceed to Buy (${cartItems.length} Items)",
                  style: const TextStyle(
                    fontFamily: 'Jost',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400, // Dibuat w600 agar lebih tegas
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}