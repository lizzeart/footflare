import 'package:flutter/material.dart';
import 'track_order_screen.dart';
import 'write_review_screen.dart';
import 'package:footflare/presentation/main_screen.dart';
import 'package:footflare/presentation/product_detail/product_detail_page.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  bool isOngoingSelected = true;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.pop(context),
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
          "My Order",
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
                onPressed: () {
                  // Fungsi ini akan pindah ke MainScreen dan menghapus semua halaman sebelumnya
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) =>
                        false, // Ini yang tadi kita bahas untuk hapus semua stack
                  );
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                ),
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.home_filled,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton("Ongoing", isOngoingSelected, () {
                    setState(() => isOngoingSelected = true);
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton("Completed", !isOngoingSelected, () {
                    setState(() => isOngoingSelected = false);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      // Efek Fade In/Out saat berganti konten
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: OrderList(
          key: ValueKey<bool>(isOngoingSelected), // Key agar animasi terpicu
          isOngoing: isOngoingSelected,
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isActive, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Kursor jadi telunjuk
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250), // Animasi invert warna
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final bool isOngoing;
  const OrderList({super.key, required this.isOngoing});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dummyOrders = [
      {
        "name": "Echo Vibe Urban Runners",
        "price": "179",
        "image": "assets/images/pic6.png",
      },
      {
        "name": "Swift Glide Sprinter Soles",
        "price": "199",
        "image": "assets/images/pic2.png",
      },
      {
        "name": "Zen Dash Active Flex Shoes",
        "price": "299",
        "image": "assets/images/pic3.png",
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: dummyOrders.length,
      separatorBuilder: (context, index) => const Divider(
        height: 40,
        thickness: 2,
        color: Color.fromARGB(255, 223, 223, 223),
      ),
      // Di dalam itemBuilder pada MyOrderScreen
      itemBuilder: (context, index) {
        final item = dummyOrders[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO PRODUK (Navigasi ke Detail & Kursor Telunjuk)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(
                        product: {
                          "name": item['name'],
                          "price": "\$${item['price']}",
                          "image": item['image'],
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // INFORMASI PRODUK
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    style: const TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "\$${item['price']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Penambahan teks FREE Delivery sesuai gambar
                      const Text(
                        "FREE Delivery",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "40% Off",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  const SizedBox(height: 8),

                  // TOMBOL TRACK ORDER / WRITE REVIEW
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isOngoing) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrackOrderScreen(item: item),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WriteReviewScreen(item: item),
                            ),
                          );
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F3F3),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ).copyWith(
                            // Efek Gelap saat Hover
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                  (states) =>
                                      states.contains(WidgetState.hovered)
                                      ? Colors.black.withOpacity(0.05)
                                      : null,
                                ),
                          ),
                      child: Text(isOngoing ? "Track Order" : "Write Review"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
