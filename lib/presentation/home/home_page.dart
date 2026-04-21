import 'package:flutter/material.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/side_drawer.dart';
import 'widgets/promo_banner.dart';
import 'widgets/brand_list.dart';
import 'widgets/product_grid.dart';
import '../category/category_page.dart';
import '../main_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCategory = 0;

  final List<String> cats = [
    'All',
    'Child',
    'Man',
    'Woman',
    'Unisex'
  ];

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.all(20),
              child: _buildSearchBar(
                  context, isDark),
            ),

            const SizedBox(height: 10),

            const PromoBanner(),

            const SizedBox(height: 24),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(
                    context,
                    'Top Brands',
                    'View All',
                  ),

                  const SizedBox(height: 16),

                  const BrandList(),

                  const SizedBox(height: 24),

                  Text(
                    'New Arrival',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                      color: Theme.of(
                              context)
                          .colorScheme
                          .onSurface,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildCategories(
                      context, isDark),

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

  Widget _buildCategories(
      BuildContext context,
      bool isDark) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal,
        itemCount: cats.length,
        itemBuilder: (context, i) {
          return _HoverCategoryItem(
            text: cats[i],
            active:
                selectedCategory == i,
            isDark: isDark,
            onTap: () {
              setState(() {
                selectedCategory = i;
              });

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MainScreen(
                    initialIndex: 3,
                  ),
                ),
              );
            },            
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(
      BuildContext context,
      bool isDark) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              decoration:
                  InputDecoration(
                hintText:
                    'Search Product',
                filled: true,
                fillColor: isDark
                    ? const Color(
                        0xFF2A2D3A)
                    : Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                              12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 50,
          width: 50,
          decoration:
              BoxDecoration(
            color: isDark
                ? Colors.white
                : Colors.black,
            borderRadius:
                BorderRadius
                    .circular(12),
          ),
          child: Icon(
            Icons.tune,
            color: isDark
                ? Colors.black
                : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
      BuildContext context,
      String title,
      String action) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight:
                FontWeight.bold,
            color: Theme.of(
                    context)
                .colorScheme
                .onSurface,
          ),
        ),
        Text(
          action,
          style: TextStyle(
            fontSize: 14,
            decoration:
                TextDecoration
                    .underline,
            color: Theme.of(
                    context)
                .colorScheme
                .onSurface,
          ),
        ),
      ],
    );
  }
}

class _HoverCategoryItem
    extends StatefulWidget {
  final String text;
  final bool active;
  final bool isDark;
  final VoidCallback onTap;

  const _HoverCategoryItem({
    required this.text,
    required this.active,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_HoverCategoryItem>
      createState() =>
          _HoverCategoryItemState();
}

class _HoverCategoryItemState
    extends State<_HoverCategoryItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final active =
        widget.active || hover;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hover = true;
        });
      },
      onExit: (_) {
        setState(() {
          hover = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration:
              const Duration(
                  milliseconds:
                      250),
          margin:
              const EdgeInsets.only(
                  right: 10),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration:
              BoxDecoration(
            color: active
                ? Colors.black
                : Colors.grey
                    .shade100,
            borderRadius:
                BorderRadius
                    .circular(8),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: active
                    ? Colors.white
                    : Colors.black,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}