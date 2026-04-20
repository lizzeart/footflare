import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _promos = [
    {
      'subtitle': "WOMAN'S SHOES",
      'title': 'Nike SB Zoom\nStefan Janoski',
    },
    {
      'subtitle': "MEN'S RUNNING",
      'title': 'Adidas UltraBoost\nLight Performance',
    },
    {
      'subtitle': "LIMITED EDITION",
      'title': 'Air Jordan 1\nRetro High Classic',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200, 
      child: PageView.builder(
        controller: _pageController,
        itemCount: _promos.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final promo = _promos[index];
          final bool isActive = _currentPage == index;

          return Container(
            width: double.infinity,
            color: const Color(0xFFF3EFE6), // Tetap statis warnanya
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  left: isActive ? 0 : -30, 
                  top: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isActive ? 1.0 : 0.0,
                    child: Text(
                      promo['subtitle']!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  left: isActive ? 0 : -30,
                  top: 45,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: isActive ? 1.0 : 0.0,
                    child: Text(
                      promo['title']!,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2, color: Colors.black),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutCubic,
                  left: isActive ? 0 : -30,
                  bottom: 10,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 900),
                    opacity: isActive ? 1.0 : 0.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Text('Shop Now', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _promos.length,
                      (dotIndex) => Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: _currentPage == dotIndex ? 16 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color: _currentPage == dotIndex ? Colors.black : Colors.black26,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}