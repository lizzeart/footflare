import 'dart:math' as math;
import 'package:flutter/material.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final PageController _pageController = PageController(initialPage: 3000);
  int _currentPage = 3000;

  final List<Map<String, String>> _promos = [
    {
      'subtitle': "WOMAN'S SHOES",
      'title': 'Nike SB Zoom\nStefan Janoski',
      'image': 'assets/images/kaki-1.png',
    },
    {
      'subtitle': "MEN'S RUNNING",
      'title': 'Adidas UltraBoost\nLight Performance',
      'image': 'assets/images/kaki-2.png',
    },
    {
      'subtitle': "LIMITED EDITION",
      'title': 'Air Jordan 1\nRetro High Classic',
      'image': 'assets/images/kaki-3.png',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190, 
      decoration: const BoxDecoration(
        color: Color(0xFFF3EFE6), 
      ),
      child: Stack(
        children: [
          // --- 1. RECTANGLE PUTIH STATIS ---
          Positioned(
            right: 35, 
            bottom: 0, 
            width: 100, 
            height: 170, 
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(200), 
                  bottom: Radius.zero,       
                ),
              ),
            ),
          ),

          // --- 2. FOTO KAKI (ANIMASI MEMUDAR) ---
          Positioned(
            right: 0, 
            top: 0, 
            bottom: 0, 
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                // PERBAIKAN FATAL: Wajib cek haveDimensions agar tidak layar merah!
                double page = _pageController.initialPage.toDouble();
                if (_pageController.hasClients && _pageController.position.haveDimensions) {
                  page = _pageController.page!;
                }
                
                double realPage = page % _promos.length;

                return Stack(
                  alignment: Alignment.centerRight,
                  children: List.generate(_promos.length, (i) {
                    double diff = (realPage - i).abs();
                    double circularDiff = math.min(diff, _promos.length - diff);
                    double opacity = (1 - circularDiff).clamp(0.0, 1.0);

                    return Opacity(
                      opacity: opacity,
                      child: Image.asset(
                        _promos[i]['image']!,
                        fit: BoxFit.fitHeight, 
                      ),
                    );
                  }),
                );
              },
            ),
          ),

          // --- 3. KONTEN DINAMIS (TEKS & TOMBOL) ---
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final realIndex = index % _promos.length;
              final promo = _promos[realIndex];

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  // PERBAIKAN FATAL: Wajib cek haveDimensions untuk teks
                  double pageOffset = (_pageController.initialPage - index).toDouble();
                  if (_pageController.hasClients && _pageController.position.haveDimensions) {
                    pageOffset = _pageController.page! - index;
                  }

                  double subtitleOffset = pageOffset * 150;
                  double titleOffset = pageOffset * 50;
                  double buttonOffset = -pageOffset * 150;
                  double opacity = (1 - pageOffset.abs() * 1.5).clamp(0.0, 1.0);

                  return Container(
                    width: double.infinity,
                    color: Colors.transparent, 
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20 + subtitleOffset,
                          top: 25,
                          child: Opacity(
                            opacity: opacity,
                            child: Text(
                              promo['subtitle']!,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: Colors.redAccent, 
                                fontSize: 12, 
                                letterSpacing: 1.2
                              ),
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 20 + titleOffset,
                          top: 50,
                          child: Opacity(
                            opacity: opacity,
                            child: Text(
                              promo['title']!,
                              style: const TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.w500,
                                fontSize: 23, 
                                height: 1.2, 
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        
                        Positioned(
                          left: 20 + buttonOffset,
                          bottom: 25,
                          child: Opacity(
                            opacity: opacity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Shop Now', 
                                style: TextStyle(
                                  fontFamily: 'Jost',
                                  fontWeight: FontWeight.w400 
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}