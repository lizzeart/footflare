import 'package:flutter/material.dart';
import 'my_order_screen.dart';

class WriteReviewScreen extends StatefulWidget {
  final Map<String, String> item;
  const WriteReviewScreen({super.key, required this.item});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  int rating = 4;
  String recommendation = "Yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: _buildHeaderButton(
          Icons.arrow_back_ios_new,
          () => Navigator.pop(context),
        ),
        title: const Text(
          "Write Review",
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
          children: [
            _buildProductHeader(context, widget.item),
            const SizedBox(height: 16),
            const Divider(thickness: 1, color: Color(0xFFF3F3F3)),
            const SizedBox(height: 24),
            const Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Jost',
              ),
            ),
            const Text(
              "Your Average Rating Is 4.0",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (i) => IconButton(
                  onPressed: () => setState(() => rating = i + 1),
                  icon: Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFB3261E),
                    size: 36,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildInputLabel("Review Title"),
            _buildTextField(1),
            const SizedBox(height: 20),
            _buildInputLabel("Product Review"),
            _buildTextField(4),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Would you recommend this product to a friend?",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "Yes",
                  groupValue: recommendation,
                  activeColor: Colors.black,
                  onChanged: (v) =>
                      setState(() => recommendation = v.toString()),
                ),
                const Text("Yes"),
                const SizedBox(width: 16),
                Radio(
                  value: "No",
                  groupValue: recommendation,
                  activeColor: Colors.black,
                  onChanged: (v) =>
                      setState(() => recommendation = v.toString()),
                ),
                const Text("No"),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Submit Order",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Jost',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onTap,
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

  Widget _buildInputLabel(String label) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    ),
  );

  Widget _buildTextField(int lines) => TextField(
    maxLines: lines,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD9D9D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black),
      ),
    ),
  );
}
