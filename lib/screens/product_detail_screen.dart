import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedColorIndex = 0;
  String selectedSize = 'L';
  bool isFavorite = false;

  final List<Color> availableColors = const [
    Color(0xFFE0C8B1),
    Colors.black,
    Color(0xFFE07A70),
  ];

  final List<String> availableSizes = const ['S', 'M', 'L'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 420,
                  width: double.infinity,
                  color: const Color(0xFFF6F6F6),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 280,
                        height: 280,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFE8E1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned.fill(
                        child: Image.network(
                          widget.product.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(
                            Icons.checkroom,
                            size: 120,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Row(
                          children: [
                            _buildDot(isActive: true),
                            _buildDot(isActive: false),
                            _buildDot(isActive: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  transform: Matrix4.translationValues(0, -20, 0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '\$ ${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          ...List.generate(
                            5,
                                (index) => Icon(
                              Icons.star,
                              size: 18,
                              color: index < (widget.product.rating?.floor() ?? 4)
                                  ? const Color(0xFF5A756C)
                                  : Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${widget.product.reviewCount ?? 12})',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Color', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              const SizedBox(height: 8),
                              Row(
                                children: List.generate(
                                  availableColors.length,
                                      (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: selectedColorIndex == index
                                              ? Colors.grey
                                              : Colors.transparent,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: availableColors[index],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Size', style: TextStyle(color: Colors.grey, fontSize: 13)),
                              const SizedBox(height: 8),
                              Row(
                                children: availableSizes.map((size) {
                                  final isSelected = selectedSize == size;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = size;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? const Color(0xFF4A4A4A)
                                            : const Color(0xFFF5F5F5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          size,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(),

                      // Description
                      ExpansionTile(
                        title: const Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                        ),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        initiallyExpanded: true,
                        children: [
                          Text(
                            (widget.product.description != null && widget.product.description!.isNotEmpty)
                                ? widget.product.description!
                                : 'Sportwear is no longer underculture, it is no longer indie or cobbled together as it once was. Sport is fashion today.',
                            style: const TextStyle(color: Colors.grey, height: 1.5, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Color(0xFF343434),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.product.name} a fost adăugat în coș!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 10),
                Text(
                  'Add To Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: isActive ? 8 : 6,
      height: isActive ? 8 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.black : Colors.grey[400],
      ),
    );
  }
}