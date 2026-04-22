import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
      child: ListTile(
        leading: Icon(
          Icons.location_on,
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Text(
          "Nama Alamat",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        subtitle: const Text(
          "Detail Alamat Lengkap...",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
