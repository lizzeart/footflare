import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/app_install_popup.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/side_drawer.dart';
import 'widgets/promo_banner.dart';
import 'widgets/brand_list.dart';
import 'widgets/product_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInstallPopup();
    });
  }

  void _showInstallPopup() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const AppInstallPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: const HomeAppBar(),
      bottomNavigationBar: const CustomBottomNav(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSearchBar(context, isDark),
            ),
            const SizedBox(height: 10),
            
            // PromoBanner dipanggil full-width tanpa padding
            const PromoBanner(),
            
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, 'Top Brands', 'View All'),
                  const SizedBox(height: 16),
                  const BrandList(),
                  const SizedBox(height: 24),
                  Text('New Arrival', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  const SizedBox(height: 16),
                  _buildCategories(context, isDark),
                  const SizedBox(height: 16),
                  const ProductGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
              color: isDark ? const Color(0xFF2A2D3A) : Colors.white,
            ),
            child: Text('Search Product', style: TextStyle(color: Colors.grey.shade500)),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black, 
            borderRadius: BorderRadius.circular(12)
          ),
          child: Icon(Icons.tune, color: isDark ? Colors.black : Colors.white),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
        Text(action, style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: Theme.of(context).colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildCategories(BuildContext context, bool isDark) {
    final cats = ['All', 'Child', 'Man', 'Woman', 'Unisex'];
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, index) {
          bool isActive = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? (isDark ? Colors.white : Colors.black) : (isDark ? const Color(0xFF2A2D3A) : Colors.grey.shade100),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                cats[index], 
                style: TextStyle(color: isActive ? (isDark ? Colors.black : Colors.white) : (isDark ? Colors.white70 : Colors.black), fontWeight: FontWeight.w500)
              ),
            ),
          );
        },
      ),
    );
  }
}