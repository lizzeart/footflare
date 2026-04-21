import 'package:flutter/material.dart';
import 'address_list_screen.dart';
import 'payment_screen.dart';
import 'my_order_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutScreen({super.key, required this.items});

  void _navigateTo(BuildContext context, Widget target) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => target,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = items.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['qty']),
    );
    double discount = 100.0;
    double totalOrder = subtotal - discount;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildBackButton(context),
        title: const Text(
          "Checkout",
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
                  // --- SECTION ADDRESS & PAYMENT DENGAN PEMISAH GARIS ---
                  _buildListTile(
                    context,
                    icon: Icons.location_on,
                    title: "Delivery Address",
                    subtitle: "123 Main Street, Anytown, USA 12345",
                    onTap: () =>
                        _navigateTo(context, const AddressListScreen()),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1.5,
                    color: Color(0xFFF3F3F3),
                  ),
                  // Di checkout_screen.dart, pada bagian tombol Payment Tile
                  _buildListTile(
                    context,
                    icon: Icons.account_balance_wallet,
                    title: "Payment",
                    subtitle: "XXXX XXXX XXXX 3456",
                    // UBAH NAVIGASI DISINI
                    onTap: () => _navigateTo(context, const PaymentScreen()),
                  ),

                  // ------------------------------------------------------
                  const SizedBox(height: 24),
                  const Text(
                    "Additional Notes:",
                    style: TextStyle(
                      fontFamily: 'Jost',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildNoteField(),
                ],
              ),
            ),
          ),

          // --- SECTION RINGKASAN HARGA (RATA BAWAH) ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF3F3F3), width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...items
                    .map(
                      (item) => _buildSummaryRow(
                        item['name'],
                        "${item['qty']} x \$${(item['price'] as num).toStringAsFixed(2)}",
                        isBold: true,
                      ),
                    )
                    .toList(),
                _buildSummaryRow(
                  "Discount",
                  "-\$${discount.toStringAsFixed(2)}",
                  isBold: true,
                ),
                _buildSummaryRow(
                  "Shipping",
                  "FREE Delivery",
                  isGreen: true,
                  isBold: true,
                ),
                const Divider(height: 30, thickness: 1.5, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "My Order",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "\$${totalOrder.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSubmitButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isGreen = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Jost',
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w400 : FontWeight.w400,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Jost',
              fontSize: 15,
              color: isGreen ? Colors.green : Colors.black,
              fontWeight: isBold ? FontWeight.w400 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MyOrderScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
        child: const Text(
          "Submit Order",
          style: TextStyle(
            fontFamily: 'Jost',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
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
          style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
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

  Widget _buildNoteField() {
    return TextField(
      maxLines: 3,
      style: const TextStyle(fontFamily: 'Jost'),
      decoration: InputDecoration(
        hintText: "Write Here",
        hintStyle: const TextStyle(
          fontFamily: 'Jost',
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF3F3F3), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}
