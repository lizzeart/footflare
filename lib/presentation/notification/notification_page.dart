import 'package:flutter/material.dart';
import '../search/search_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxColor = isDark ? const Color(0xFF2A2D3A) : Colors.grey.shade100;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.arrow_back_ios_new, size: 16)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notification (12)'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.search, size: 20)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(height: 1, color: isDark ? Colors.white10 : Colors.black12),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: const CircleAvatar(radius: 25, backgroundColor: Colors.blueAccent, child: Icon(Icons.person, color: Colors.white)),
            title: Text('New Arrivals Alert!', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
            subtitle: const Text('15 July 2023', style: TextStyle(color: Colors.grey, fontSize: 12)),
          );
        },
      ),
    );
  }
}