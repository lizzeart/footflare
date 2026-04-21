import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
          'Edit Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  
                  // Foto Profil dengan Ring dan Ikon Edit
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4), // Jarak ring putih
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: const CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                          ),
                        ),
                        // Tombol Pensil/Edit
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(Icons.edit_outlined, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Form Inputs
                  _buildInputField(
                    icon: Icons.lock_outline, 
                    label: "Name", 
                    initialValue: "Ada Wong"
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    icon: Icons.mail_outline, 
                    label: "Email Address", 
                    hint: "Email Address"
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    icon: Icons.phone_outlined, 
                    label: "Mobile Number", 
                    hint: "Mobile Number"
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    icon: Icons.location_on, 
                    label: "Location", 
                    hint: "Location"
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button (Update Profile)
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Helper untuk Input Field
  Widget _buildInputField({required IconData icon, required String label, String? initialValue, String? hint}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          // Bagian Ikon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          // Garis Vertikal Pemisah
          Container(
            height: 60,
            width: 1,
            color: Colors.grey.shade300,
          ),
          // Bagian Input
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                initialValue: initialValue,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                  hintText: hint,
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}