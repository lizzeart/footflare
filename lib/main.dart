import 'package:flutter/material.dart';
import 'presentation/home/home_page.dart';

// Variabel global untuk mengatur tema
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const FootFlareApp());
}

class FootFlareApp extends StatelessWidget {
  const FootFlareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'FootFlare',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode, 
          
          // --- PENGATURAN MODE SIANG ---
          theme: ThemeData(
            fontFamily: 'Jost',
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              surface: Colors.white,
              onSurface: Colors.black, 
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Jost'),
            ),
            drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          ),

          // --- PENGATURAN MODE MALAM ---
          darkTheme: ThemeData(
            fontFamily: 'Jost',
            scaffoldBackgroundColor: const Color(0xFF1B1D27), // Warna background gelap khusus
            colorScheme: const ColorScheme.dark(
              primary: Colors.white,
              surface: Color(0xFF2A2D3A), 
              onSurface: Colors.white, 
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1B1D27),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Jost'),
            ),
            drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1B1D27)),
          ),
          
          home: const HomePage(),
        );
      },
    );
  }
}