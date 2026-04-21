import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk mengambil gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18, color: onSurface),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Jost'),
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
                  
                  // Foto Profil dengan Fungsi Ganti Foto
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: onSurface, width: 1.5),
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: _image != null 
                                ? FileImage(_image!) as ImageProvider
                                : const NetworkImage('https://i.pravatar.cc/300'),
                          ),
                        ),
                        // Tombol Edit
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white : Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 3),
                            ),
                            child: Icon(
                              Icons.edit_outlined, 
                              color: isDark ? Colors.black : Colors.white, 
                              size: 20
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  _buildInputField(
                    context: context,
                    icon: Icons.person_outline, 
                    label: "Name", 
                    initialValue: "Rifki Alfaris" // Nama kamu sebagai default
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    context: context,
                    icon: Icons.mail_outline, 
                    label: "Email Address", 
                    hint: "rifki@example.com"
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    context: context,
                    icon: Icons.phone_outlined, 
                    label: "Mobile Number", 
                    hint: "+62 812 3456 789"
                  ),
                  const SizedBox(height: 15),
                  _buildInputField(
                    context: context,
                    icon: Icons.location_on_outlined, 
                    label: "Location", 
                    hint: "Yogyakarta, Indonesia"
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Updated!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  "Update Profile",
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white, 
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost'
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context, 
    required IconData icon, 
    required String label, 
    String? initialValue, 
    String? hint
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(icon, color: onSurface, size: 24),
          ),
          Container(
            height: 60,
            width: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                initialValue: initialValue,
                style: TextStyle(fontFamily: 'Jost', color: onSurface),
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontFamily: 'Jost'),
                  hintText: hint,
                  hintStyle: const TextStyle(fontFamily: 'Jost'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}