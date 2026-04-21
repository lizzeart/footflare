import 'package:flutter/material.dart';

class NetbankingScreen extends StatelessWidget {
  const NetbankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text(
          "Net Banking",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            TextField(
              decoration: InputDecoration(
                hintText: "Search by bank name",
                hintStyle: const TextStyle(fontFamily: 'Jost'),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Popular Banks
            _buildPopularBanksCard(),

            const SizedBox(height: 24),
            const Text(
              "All Banks",
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // List Bank (Dua Kolom)
            _buildAllBanksList(),

            const SizedBox(height: 40),
            _buildReturnButton(context),
          ],
        ),
      ),
    );
  }

  // ... (Widget helper _buildPopularBanksCard, _buildAllBanksList, _buildReturnButton sama seperti sebelumnya)
  // Pastikan tetap menggunakan fontFamily 'Jost' dan kursor telunjuk pada tombol Return.
  Widget _buildReturnButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back, size: 18),
              SizedBox(width: 8),
              Text(
                "Return",
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularBanksCard() {
    final bankImages = [
      "assets/images/bank1.png",
      "assets/images/bank2.png",
      "assets/images/bank3.png",
      "assets/images/bank4.png",
      "assets/images/bank5.png",
      "assets/images/bank6.png",
      "assets/images/bank7.png",
      "assets/images/bank8.png",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular Banks",
            style: TextStyle(
              fontFamily: 'Jost',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          // 🔥 GARIS PEMISAH
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFFEAEAEA),
          ),

          const SizedBox(height: 16),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bankImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 kolom biar rapi
              mainAxisSpacing: 12, // 🔥 jarak vertikal lebih rapat
              crossAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  bankImages[index],
                  width: 56, // ukuran logo
                  height: 56,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllBanksList() {
    final banks = [
      "Bank of india",
      "Bank Of Maharasthra",
      "Canara Bank",
      "HDFC Bank",
      "IDFC Bank",
      "Catholic Syrian Bank",
      "City Union Bank",
      "Central Bank of India",
      "Cosmos Bank",
      "Corporation Bank",
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildBankColumn(banks.sublist(0, 5))),
        Expanded(child: _buildBankColumn(banks.sublist(5))),
      ],
    );
  }

  Widget _buildBankColumn(List<String> list) {
    return Column(
      children: list
          .map(
            (name) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward, size: 14),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(fontFamily: 'Jost', fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
