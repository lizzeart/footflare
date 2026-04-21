import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String discount;
  final Color? discountColor; // Warna banner diskon [cite: 56, 58]
  bool isWishlist;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.discount = "",
    this.discountColor,
    this.isWishlist = false,
  });
}