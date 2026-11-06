import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        onTap: onTap,
        leading: Image.network(
          product.imageUrl,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
        ),
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          '${product.price} ${product.currency}',
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            product.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: product.isFavorite ? Colors.red : Colors.grey,
          ),
          onPressed: onFavoriteToggle,
        ),
      ),
    );
  }
}