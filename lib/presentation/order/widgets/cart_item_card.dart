import 'package:flutter/material.dart';

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
  bool _isRemoved = false; // Flag untuk memicu animasi hapus

  @override
  Widget build(BuildContext context) {
    // AnimatedOpacity untuk efek memudar
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isRemoved ? 0.0 : 1.0,
      // AnimatedSize untuk efek slide mengecil (item lain naik ke atas)
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Container(
          height: _isRemoved ? 0 : null,
          padding: EdgeInsets.symmetric(vertical: _isRemoved ? 0 : 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isRemoved ? Colors.transparent : Colors.grey.shade100,
              ),
            ),
          ),
          child: _isRemoved
              ? const SizedBox.shrink() // Hilangkan isi widget saat dihapus
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar & Love dengan Fitur Klik ke Detail
                    _buildProductImage(context),
                    const SizedBox(width: 16),
                    // Info Produk & Controls
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          _buildPriceInfo(),
                          const SizedBox(height: 12),
                          _buildBottomActions(),
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

  Widget _buildProductImage(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(title: Text(widget.name)),
                body: const Center(child: Text("Halaman Detail Produk")),
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
                color: const Color(0xFFF5F5F5),
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

  Widget _buildPriceInfo() {
    return Row(
      children: [
        Text(
          widget.price,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
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

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Quantity Controls
        Row(
          children: [
            _qtyContainer(_qtyBtn(Icons.remove, widget.onRemove)),
            const SizedBox(width: 8),
            _qtyDisplay(),
            const SizedBox(width: 8),
            _qtyContainer(_qtyBtn(Icons.add, widget.onAdd)),
          ],
        ),
        // Tombol Remove
        MouseRegion(
          cursor: SystemMouseCursors.click, // Mengubah kursor jadi telunjuk
          child: GestureDetector(
            onTap: widget.onDelete,
            child: Row(
              children: [
                // Mengganti Icon dengan Image.asset
                Image.asset(
                  'assets/icons/trash_icon.png',
                  width: 20,
                  height: 20,
                  color: Colors
                      .grey
                      .shade500, // Opsional: kasih warna kalau filenya tipe siluet/masking
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

  Widget _qtyContainer(Widget child) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _qtyDisplay() {
    return Container(
      width: 40,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      alignment: Alignment.center,
      child: Text(
        '${widget.quantity}',
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback action) {
    return IconButton(
      onPressed: action,
      // Menggunakan styleFrom adalah cara yang lebih standar sekarang
      style: IconButton.styleFrom(
        splashFactory:
            NoSplash.splashFactory, // Mematikan efek percikan air saat diklik
        padding: EdgeInsets.zero,
      ),
      icon: Icon(icon, size: 16, color: Colors.black),
    );
  }
}
