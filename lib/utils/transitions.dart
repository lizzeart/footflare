import 'package:flutter/material.dart';

Route slideInRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Animasi Slide dari kanan ke kiri
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.easeInOutCubic;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return Stack(
        children: [
          // Efek Gelap Perlahan pada halaman sebelumnya (Background)
          FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 0.6).animate(animation),
            child: Container(color: Colors.black),
          ),
          // Halaman baru yang meluncur masuk
          SlideTransition(position: animation.drive(tween), child: child),
        ],
      );
    },
  );
}
