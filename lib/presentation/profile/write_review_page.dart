import 'package:flutter/material.dart';

class WriteReviewPage extends StatefulWidget {
  const WriteReviewPage({super.key});

  @override
  State<WriteReviewPage> createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  // State untuk rating bintang
  int _currentRating = 4;
  
  // State untuk rekomendasi produk
  bool _isRecommended = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Write Review',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            color: Colors.black,
            fontFamily: 'Jost',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // --- Product Card ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      'https://footflare-bootstrap-pwa.vercel.app/assets/images/product/product1/pic1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Echo Vibe Urban Runners",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            fontFamily: 'Jost',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              "\$179",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: 18,
                                fontFamily: 'Jost',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "FREE Delivery",
                              style: TextStyle(
                                color: Colors.green.shade600, 
                                fontWeight: FontWeight.w500, 
                                fontSize: 12,
                                fontFamily: 'Jost',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "40% Off",
                          style: TextStyle(
                            color: Colors.red, 
                            fontWeight: FontWeight.w500, 
                            fontSize: 14,
                            fontFamily: 'Jost',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_forward, size: 20),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Divider(color: Color(0xFFEEEEEE)),
            const SizedBox(height: 20),

            // --- Rating Section ---
            const Text(
              "Overall Rating",
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Your Average Rating Is ${_currentRating.toDouble()}",
              style: const TextStyle(
                color: Colors.grey, 
                fontSize: 15,
                fontFamily: 'Jost',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentRating = index + 1;
                    });
                  },
                  child: Icon(
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: const Color(0xFFE91E63), // Warna Pinkish-red
                    size: 45,
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // --- Input Forms ---
            _buildInputLabel("Review Title"),
            _buildTextField(hint: "Enter your review title"),
            
            const SizedBox(height: 20),
            
            _buildInputLabel("Product Review"),
            _buildTextField(hint: "Write your experience with this product", maxLines: 4),

            const SizedBox(height: 25),

            // --- Recommendation Section ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Would you recommend this product to a friend?",
                style: TextStyle(
                  fontWeight: FontWeight.w500, 
                  fontSize: 15,
                  fontFamily: 'Jost',
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _isRecommended = true),
                  child: _buildRadioButton(_isRecommended, "Yes"),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () => setState(() => _isRecommended = false),
                  child: _buildRadioButton(!_isRecommended, "No"),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // --- Submit Button ---
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan aksi kirim review di sini
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  "Submit Review",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 15,
            fontFamily: 'Jost',
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(fontFamily: 'Jost'),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.all(15),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.black : const Color(0xFFCCCCCC), 
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.black : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label, 
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500,
            fontFamily: 'Jost',
          ),
        ),
      ],
    );
  }
}