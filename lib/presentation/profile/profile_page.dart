import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Sesuaikan import ini dengan nama project dan folder kamu
import 'package:footflare/presentation/profile/language_modal.dart';
import 'package:footflare/presentation/profile/write_review_page.dart';
import 'package:footflare/presentation/profile/faq_page.dart';
import 'package:footflare/presentation/profile/coupons_page.dart';

class FootFlareProfile extends StatefulWidget {
  const FootFlareProfile({super.key});

  @override
  State<FootFlareProfile> createState() => _FootFlareProfileState();
}

class _FootFlareProfileState extends State<FootFlareProfile> {
  String selectedLanguage = "Select Language"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // Tombol Back di kiri
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: _buildSquareButton(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 18, 
            color: Colors.black, 
            fontFamily: 'Jost'
          ),
        ),
        // Tombol Search di kanan
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: _buildSquareButton(Icons.search, size: 22),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header Profile (Avatar & Name)
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCylXFV0XklUkisnNXZkn65Z1u6JSwEOopEA&s'),
                ),
                const SizedBox(width: 15),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Jost'),
                    children: [
                      TextSpan(text: "Hello, "),
                      TextSpan(
                        text: "Ada Wong",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            
            // Grid Buttons Atas
            Row(
              children: [
                Expanded(child: _buildUpperButton("Your Order")),
                const SizedBox(width: 10),
                Expanded(child: _buildUpperButton("Wishlist")),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildUpperButton(
                    "Coupons",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CouponsPage()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(child: _buildUpperButton("Track Order")),
              ],
            ),
            
            const SizedBox(height: 35),
            const Text(
              "Account Settings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Jost'),
            ),
            const SizedBox(height: 10),
            
            _buildMenuTile(Icons.person_outline, "Edit Profile", isEditProfile: true),
            _buildMenuTile(Icons.account_balance_wallet_outlined, "Saved Cards & Wallet"),
            _buildMenuTile(Icons.location_on_outlined, "Saved Addresses"),
            _buildMenuTile(Icons.translate, selectedLanguage, isLanguage: true),
            _buildMenuTile(Icons.notifications_none_outlined, "Notifications Settings"),
            _buildMenuTile(Icons.logout, "Logout", isLogout: true),
            
            const SizedBox(height: 25),
            const Text(
              "My Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Jost'),
            ),
            const SizedBox(height: 10),
            
            _buildMenuTile(Icons.star_outline, "Reviews"),
            _buildMenuTile(Icons.message_outlined, "FAQ"),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat tombol kotak di AppBar
  Widget _buildSquareButton(IconData icon, {double size = 20}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: Colors.black, size: size),
    );
  }

  // Helper untuk tombol lonjong (Orders, Wishlist, dll)
  Widget _buildUpperButton(String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Jost'),
        ),
      ),
    );
  }

  // Helper untuk baris menu pengaturan
  Widget _buildMenuTile(IconData icon, String title, 
      {bool isEditProfile = false, bool isLanguage = false, bool isLogout = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.black, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15, 
          fontWeight: FontWeight.w500,
          fontFamily: 'Jost',
          color: isLogout ? Colors.red : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
      onTap: () {
        if (isEditProfile) {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const EditProfilePage())
          );
        } else if (isLanguage) {
          LanguageModal.show(context, (languageName) {
            setState(() => selectedLanguage = languageName);
          });
        } else if (title == "Reviews") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const WriteReviewPage()));
        } else if (title == "FAQ") {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FaqPage()));
        } else if (isLogout) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Logged out successfully")));
        }
      },
    );
  }
}

// --- Halaman Edit Profile ---
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() => _imageFile = File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Jost')),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCylXFV0XklUkisnNXZkn65Z1u6JSwEOopEA&s') as ImageProvider,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 35, width: 35,
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildInputField(label: "Full Name", initialValue: "Ada Wong"),
                  const SizedBox(height: 15),
                  _buildInputField(label: "Email", initialValue: "ada.wong@example.com"),
                  const SizedBox(height: 15),
                  _buildInputField(label: "Phone Number", initialValue: "+62 812 3456 789"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Update Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, String? initialValue}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontFamily: 'Jost', color: Colors.grey),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
    );
  }
}