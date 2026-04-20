import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: isDark ? Colors.white : Colors.black, borderRadius: BorderRadius.circular(12)),
                      child: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.black : Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: 'Search Best items for You',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: isDark ? Colors.white : Colors.black)),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF2A2D3A) : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
              const SizedBox(height: 16),
              _buildCategories(context, isDark),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                  Text('Clear All', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline, color: Colors.grey.shade600)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildHistoryItem(context, 'Woman Fashion Shoes'),
                    _buildHistoryItem(context, 'Man Shoes'),
                    _buildHistoryItem(context, 'Girl Shoes'),
                    _buildHistoryItem(context, 'Shorts Shoes'),
                    _buildHistoryItem(context, 'Shorts'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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

  Widget _buildHistoryItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface)),
          const Icon(Icons.close, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}