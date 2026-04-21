import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  // Indeks untuk melacak FAQ mana yang sedang terbuka
  int? _openTileIndex = 0;

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
          'FAQ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildFaqItem(
            index: 0,
            question: "What is included with my purchase?",
            answer: "Package have the HTML files, SCSS files, CSS files, JS files, Well Define Documentation, Fonts and Icons, Responsive Designs, Image Assets, Customization Options, and many more.",
          ),
          _buildFaqItem(
            index: 1,
            question: "What features does FootFlare offer?",
            answer: "FootFlare offers a wide range of features including responsive design, customizable layouts, product catalog pages, shopping cart functionality, checkout pages, user account management, and more.",
          ),
          _buildFaqItem(
            index: 2,
            question: "Can I customize the template's design?",
            answer: "Absolutely! FootFlare is built using Bootstrap, which makes it highly customizable. You can easily adjust colors, fonts, layout structures, and more to match your brand's identity.",
          ),
          _buildFaqItem(
            index: 3,
            question: "Is the template SEO-friendly?",
            answer: "FootFlare is built with best practices in mind, including SEO optimization. You can optimize your product pages, meta tags, and other elements to improve your website's search engine visibility.",
          ),
          _buildFaqItem(
            index: 4,
            question: "Are there pre-designed page templates included?",
            answer: "Yes, FootFlare typically includes pre-designed templates for essential pages like the homepage, product listings, product details, shopping cart, checkout, and user account pages.",
          ),
          _buildFaqItem(
            index: 5,
            question: "Does FootFlare provide customer support?",
            answer: "FootFlare offers customer support options for their clients. Check the template documentation or you can directly contact to our support team from here - Click Here",
          ),
          _buildFaqItem(
            index: 6,
            question: "Is coding knowledge required to use FootFlare?",
            answer: "Basic knowledge of HTML, CSS, and Bootstrap can be helpful for customizing FootFlare to your needs. However, it's designed to be user-friendly and doesn't necessarily require extensive coding skills.",
          ),
          _buildFaqItem(
            index: 7,
            question: "How can I get started with FootFlare?",
            answer: "To get started, purchase and download the FootFlare template. Then, follow the included documentation to set up and customize your e-commerce website based on your specific requirements.",
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required int index,
    required String question,
    required String answer,
  }) {
    bool isOpen = _openTileIndex == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFF333333) : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          // Menghilangkan highlight saat diklik agar tetap bersih
          splashColor: Colors.transparent, 
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          // Menggunakan key unik berdasarkan index untuk memaksa tile tertutup saat state berubah
          key: Key('faq_$index\_$isOpen'), 
          initiallyExpanded: isOpen,
          onExpansionChanged: (expanded) {
            setState(() {
              _openTileIndex = expanded ? index : null;
            });
          },
          title: Text(
            question,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isOpen ? Colors.white : Colors.black,
            ),
          ),
          // Warna panah saat terbuka (Putih)
          iconColor: Colors.white, 
          // Warna panah saat tertutup (Hitam)
          collapsedIconColor: Colors.black,
          // Mengaktifkan kembali ikon panah bawaan untuk animasi rotasi yang smooth
          showTrailingIcon: true,
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              color: const Color(0xFFF7F7F7),
              child: Text(
                answer,
                style: const TextStyle(
                  color: Colors.black87,
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}