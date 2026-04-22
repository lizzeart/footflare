import 'package:flutter/material.dart';
import '../../product_detail/product_detail_page.dart';

class CartItemCard extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const CartItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  bool isFavorite = false;
  final bool _isRemoved = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isRemoved ? 0.0 : 1.0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          height: _isRemoved ? 0 : null,
          padding: EdgeInsets.symmetric(vertical: _isRemoved ? 0 : 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isRemoved
                    ? Colors.transparent
                    : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
              ),
            ),
          ),
          child: _isRemoved
              ? const SizedBox.shrink()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(context, isDark),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          _buildPriceInfo(isDark),
                          const SizedBox(height: 12),
                          _buildBottomActions(isDark),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // --- WIDGET HELPERS ---

  Widget _buildProductImage(BuildContext context, bool isDark) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                product: {
                  "name": widget.name,
                  "price": widget.price,
                  "image": widget.imagePath,
                },
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2D3A)
                    : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => isFavorite = !isFavorite),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey.shade400,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo(bool isDark) {
    return Row(
      children: [
        Text(
          widget.price,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "FREE Delivery",
          style: TextStyle(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _qtyContainer(
              _qtyBtn(Icons.remove, widget.onRemove, isDark),
              isDark,
            ),
            const SizedBox(width: 8),
            _qtyDisplay(isDark),
            const SizedBox(width: 8),
            _qtyContainer(_qtyBtn(Icons.add, widget.onAdd, isDark), isDark),
          ],
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onDelete,
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/trash_icon.png',
                  width: 20,
                  height: 20,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 4),
                const Text(
                  "Remove",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _qtyContainer(Widget child, bool isDark) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2D3A) : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _qtyDisplay(bool isDark) {
    return Container(
      width: 40,
      height: 36,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1F28) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${widget.quantity}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback action, bool isDark) {
    return IconButton(
      onPressed: action,
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.zero,
      ),
      icon: Icon(icon, size: 16, color: isDark ? Colors.white : Colors.black),
    );
  }
}
