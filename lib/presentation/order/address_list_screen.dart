import 'package:flutter/material.dart';
import 'add_address_screen.dart'; // PASTIKAN IMPORT INI ADA

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  int selectedIndex = 1;

  final List<Map<String, dynamic>> addressList = [
    {
      "id": 0,
      "type": "Home Address",
      "desc": "123 Main Street, USA",
      "icon": Icons.home_rounded,
    },
    {
      "id": 1,
      "type": "Office Address",
      "desc": "456 Elm Avenue, USA",
      "icon": Icons.location_on_rounded,
    },
    {
      "id": 2,
      "type": "Home Address",
      "desc": "789 Maple Lane, USA",
      "icon": Icons.home_rounded,
    },
    {
      "id": 3,
      "type": "Shop Address",
      "desc": "654 Pine Road, USA",
      "icon": Icons.shopping_bag_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 52,
        leading: _buildSquareButton(
          icon: Icons.arrow_back_ios_new,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Delivery Address",
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
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...addressList.map((addr) => _buildAddressItem(addr)).toList(),
                const SizedBox(height: 20),
                // TOMBOL ADD ADDRESS YANG SUDAH DIPERBAIKI
                _buildAddAddressButton(context),
              ],
            ),
          ),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildAddressItem(Map<String, dynamic> addr) {
    bool isSelected = selectedIndex == addr['id'];
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = addr['id']),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100, width: 2.0),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(addr['icon'], color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addr['type'],
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      addr['desc'],
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? Colors.black : Colors.grey.shade300,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // NAVIGASI INSTAN KE HALAMAN ADD ADDRESS
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const AddAddressScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: const Row(
            children: [
              Icon(Icons.add_circle_outline, color: Colors.black, size: 22),
              SizedBox(width: 12),
              Text(
                "Add Address",
                style: TextStyle(
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 56),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          child: const Text(
            "Save Address",
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

  Widget _buildSquareButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            splashFactory: NoSplash.splashFactory,
          ).copyWith(overlayColor: WidgetStateProperty.all(Colors.transparent)),
          padding: EdgeInsets.zero,
          icon: Icon(icon, color: Colors.black, size: 18),
        ),
      ),
    );
  }
}
