import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  // Controller untuk menangkap input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        // Tombol kembali kotak abu-abu (simetri dengan halaman lain)
        leading: _buildSquareBackButton(context),
        title: const Text(
          "Add Card",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- KARTU VISUAL (MERAH MARUN) SESUAI GAMBAR ---
                  _buildVisualCard(),
                  const SizedBox(height: 24),

                  // --- FORMULIR INPUT ---
                  _buildInputLabel("Card Name"),
                  _buildInputField(_nameController, "Roopa Smith"),

                  const SizedBox(height: 16),
                  _buildInputLabel("Card Number"),
                  _buildInputField(
                    _numberController,
                    "**** **** **** 4532",
                    isNumber: true,
                  ),

                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Expired Date (Kiri)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel("Expiry Date"),
                            _buildInputField(_expiryController, "mm/dd/yyyy"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // CVV (Kanan)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel("CVV"),
                            _buildInputField(
                              _cvvController,
                              "012",
                              isNumber: true,
                              isObscure: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- TOMBOL ADD CARD (RATA BAWAH) ---
          _buildAddCardButton(),
        ],
      ),
    );
  }

  // --- WIDGET HELPER ---

  // 1. Kartu Visual Merah Marun
  Widget _buildVisualCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF8D1C3D), // Warna merah marun sesuai gambar
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "CREDIT CARD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
              // Logo Visa Putih
              Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Nomor Kartu Besar
          const Text(
            "**** **** **** 4532",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Nama Pemegang Kartu (Kiri Bawah)
              const Text(
                "ROOPA SMITH",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              // Exp & CVV (Kanan Bawah)
              Row(
                children: [
                  _buildCardInfoPair("EXP", "14/07"),
                  const SizedBox(width: 16),
                  _buildCardInfoPair("CVV", "012"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper untuk teks kecil di dalam kartu (EXP/CVV)
  Widget _buildCardInfoPair(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // 2. Label Input (Jost, w500)
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
    );
  }

  // 3. Input Field (Garis lebih tebal, tanpa shadow hover)
  Widget _buildInputField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
    bool isObscure = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      obscureText: isObscure,
      style: const TextStyle(fontFamily: 'Jost', fontSize: 15),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Jost',
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        // Garis border dipertebal (1.5)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }

  // 4. Tombol Add Card (Rata bawah, No shadow hover)
  Widget _buildAddCardButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F3F3))),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () {
            // Aksi simpan kartu
            Navigator.pop(context);
          },
          style:
              ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 56),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ).copyWith(
                // Menghilangkan efek hover/shadow
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
          child: const Text(
            "Add Card",
            style: TextStyle(
              fontFamily: 'Jost',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Tombol Kembali Kotak (Simetri)
  Widget _buildSquareBackButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
        ),
      ),
    );
  }
}
