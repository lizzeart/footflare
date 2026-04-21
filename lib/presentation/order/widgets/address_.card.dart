import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.location_on),
        title: Text("Nama Alamat"),
        subtitle: Text("Detail Alamat Lengkap..."),
      ),
    );
  }
}
