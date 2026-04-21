import 'package:flutter/material.dart';
import 'my_order_screen.dart'; // Untuk DummyDetailProduct

class TrackOrderScreen extends StatelessWidget {
  final Map<String, String> item;
  const TrackOrderScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _buildHeaderButton(context, Icons.arrow_back_ios_new),
        title: const Text(
          "Track Order",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductHeader(context, item),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Color(0xFFF3F3F3)),
            const SizedBox(height: 24),
            const Text(
              "Track order",
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            // Mengembalikan menjadi 5 proses sesuai gambar referensi
            _buildTimelineStep(
              "Order Placed",
              "We have received your order",
              "27 Dec 2023",
              true,
              false,
            ),
            _buildTimelineStep(
              "Order Confirm",
              "We has been confirmed",
              "27 Dec 2023",
              true,
              false,
            ),
            _buildTimelineStep(
              "Order Processed",
              "We are preparing your order",
              "28 Dec 2023",
              false,
              false,
            ),
            _buildTimelineStep(
              "Ready To Ship",
              "Your order is ready for shipping",
              "29 Dec 2023",
              false,
              false,
            ),
            _buildTimelineStep(
              "Out For Delivery",
              "Your order is out for delivery",
              "31 Dec 2023",
              false,
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(BuildContext context, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(icon, color: Colors.black, size: 18),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  // Cari bagian ini di track_order_screen.dart (biasanya di bagian bawah)

  Widget _buildProductHeader(BuildContext context, Map<String, String> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DummyDetailProduct(),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F3F3),
                borderRadius: BorderRadius.circular(12),
              ),
              // --- GANTI DI SINI ---
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['image']!, // Pastikan di layar sebelumnya kamu sudah kirim key 'image'
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              // ---------------------
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 100,
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
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DummyDetailProduct(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.arrow_forward, size: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineStep(
    String title,
    String sub,
    String date,
    bool isDone,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? const Color(0xFFB3261E) : Colors.white,
                border: Border.all(
                  color: isDone ? const Color(0xFFB3261E) : Colors.grey,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isDone ? const Color(0xFFB3261E) : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      color: isDone ? const Color(0xFFB3261E) : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Text(sub, style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
