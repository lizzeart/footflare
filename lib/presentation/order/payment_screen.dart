import 'package:flutter/material.dart';
import '../../utils/transitions.dart';
import 'netbanking_screen.dart';
import 'add_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Variabel untuk menyimpan metode mana yang sedang dipilih/meluas
  String selectedMethod = "Credit"; // Default: Credit Card sesuai Foto 5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildBackButton(context),
        title: const Text(
          "Payment",
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
                  // --- SECTION CARDS (HORIZONTAL SCROLL) ---
                  _buildCardSection(),
                  const SizedBox(height: 24),

                  // --- DAFTAR METODE PEMBAYARAN (EXPANDABLE) ---
                  _buildExpandableMethod(
                    id: "Cash",
                    icon: Icons.attach_money_rounded,
                    title: "Cash on Delivery(Cash/UPI)",
                    expandedChild: _buildCashDetail(), // Detail sesuai Foto 6
                  ),
                  _buildExpandableMethod(
                    id: "UPI",
                    icon: Icons.qr_code_scanner_rounded,
                    title: "Google Pay/Phone Pay/BHIM UPI",
                    expandedChild:
                        _buildUPIDetail(), // Detail sesuai Foto 5 (Expanded)
                  ),
                  _buildExpandableMethod(
                    id: "Wallet",
                    icon: Icons.account_balance_wallet_outlined,
                    title: "Payments/Wallet",
                    expandedChild: _buildWalletDetail(), // Detail sesuai Foto 7
                  ),
                  _buildExpandableMethod(
                    id: "Netbanking",
                    icon: Icons.account_balance_rounded,
                    title: "Netbanking",
                    expandedChild:
                        _buildNetbankingDetail(), // Detail sesuai Foto 8
                  ),
                ],
              ),
            ),
          ),
          // Tombol Continue di Paling Bawah
          _buildContinueButton(),
        ],
      ),
    );
  }

  // --- WIDGET HELPER UTAMA UNTUK KOTAK YANG BISA MELUAS ---
  Widget _buildExpandableMethod({
    required String id,
    required IconData icon,
    required String title,
    required Widget expandedChild,
  }) {
    bool isSelected = selectedMethod == id;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF9F9F9,
        ), // Warna abu-abu sangat muda sesuai referensi
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.grey.shade300) : null,
      ),
      child: Column(
        children: [
          // Bagian Header (Selalu muncul, kursor telunjuk)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () =>
                  setState(() => selectedMethod = isSelected ? "" : id),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(icon, color: Colors.black, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // Radio Button
                    Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected ? Colors.black : Colors.grey.shade400,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bagian Detail (Hanya muncul jika dipilih, animasi meluas)
          // Ganti AnimatedCrossFade (baris 668-681) dengan kode di bawah ini:
          AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Container(
              width: double.infinity,
              child: !isSelected
                  ? const SizedBox.shrink()
                  : Column(
                      children: [
                        // Garis pemisah tipis saat terbuka
                        const Divider(height: 1, color: Color(0xFFF3F3F3)),
                        // Animasi "Membuka" (seperti berkedip/slide down)
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn,
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, value, child) {
                            return ClipRect(
                              child: Align(
                                alignment: Alignment.topCenter,
                                heightFactor:
                                    value, // Ini yang membuat efek "membuka"
                                child: Opacity(
                                  opacity: value, // Efek muncul perlahan
                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: expandedChild,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // --- WIDGET DETAIL UNTUK MASING-MASING METODE (SESUAI FOTO REFERENSI) ---
  // ===========================================================================

  // 1. Detail Cash (Foto 6)
  Widget _buildCashDetail() {
    return Align(
      // Gunakan Align agar teks menempel ke sisi kiri container
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          "Carry on your cash payment..\nThanx!",
          textAlign:
              TextAlign.left, // Tetap gunakan left untuk teks multi-baris
          style: const TextStyle(
            fontFamily: 'Jost',
            color: Colors.grey,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  // 2. Detail UPI (Foto 5 Expanded)
  Widget _buildUPIDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          "Link via UPI",
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        _buildMinimalInputField("Enter your UPI ID"),
        _buildInlineContinueButton(),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
            SizedBox(width: 8),
            Text(
              "Your UPI ID Will be encrypted and is 100% safe with us.",
              style: TextStyle(
                fontFamily: 'Jost',
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 3. Detail Wallet (Foto 7)
  Widget _buildWalletDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          "Link Your Wallet",
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        _buildMinimalInputField("+91"), // Contoh nomor India sesuai referensi
        _buildInlineContinueButton(),
      ],
    );
  }

  // 4. Detail Netbanking (Foto 8)
  Widget _buildNetbankingDetail() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        onTap: () =>
            Navigator.push(context, slideInRoute(const NetbankingScreen())),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text(
          "Netbanking",
          style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.bold),
        ),
        subtitle: const Text(
          "Carry on your payment by select your bank",
          textAlign: TextAlign.left,
          style: TextStyle(fontFamily: 'Jost', fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  // ===========================================================================
  // --- SECTION KARTU KREDIT (HORIZONTAL SCROLL) ---
  // ===========================================================================
  Widget _buildCardSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Credit/Debit Card",
              style: TextStyle(
                fontFamily: 'Jost',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const AddCardScreen(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 18,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Add Card",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // ✅ Tambah parameter type di sini
              _buildVisaCard(
                Colors.black,
                "4532",
                "ROOPA SMITH",
                "CREDIT CARD",
              ),
              _buildVisaCard(
                const Color(0xFF3DA384),
                "1234",
                "ROOPA SMITH",
                "DEBIT CARD",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ✅ Tambah parameter type
  Widget _buildVisaCard(
    Color bgColor,
    String lastFour,
    String name,
    String type,
  ) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                // KIRI ATAS (radio + text)
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.radio_button_checked,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // KANAN ATAS (LOGO)
                Align(
                  alignment: Alignment.topRight,
                  child: type == "DEBIT CARD"
                      ? SizedBox(
                          width: 50,
                          height: 30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(
                                      0.6,
                                    ), // ⬅️ ini
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 14,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(
                                      0.6,
                                    ), // beda dikit biar ada depth
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.asset(
                          "assets/images/visa.png",
                          width: 45,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "**** **** **** $lastFour",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "EXP",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  Text(
                    "14/07",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "CVV",
                    style: TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                  Text(
                    "012",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // --- INPUT FIELD & BUTTON KECIL (UNTUK DETAIL METODE) ---
  // ===========================================================================
  Widget _buildMinimalInputField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        style: const TextStyle(fontFamily: 'Jost'),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Jost',
            color: Colors.grey,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildInlineContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: const Text(
            "Continue",
            style: TextStyle(
              fontFamily: 'Jost',
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // --- TOMBOL STANDAR (BACK & BOTTOM CONTINUE) ---
  // ===========================================================================
  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () =>
              Navigator.pop(context), // Selesai payment kembali ke Checkout
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: const Text(
            "Continue",
            style: TextStyle(
              fontFamily: 'Jost',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
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
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
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
