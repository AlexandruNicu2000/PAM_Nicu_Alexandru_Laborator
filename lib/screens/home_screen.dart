import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> featureProducts = [
    Product(
      id: '1',
      title: 'Turtleneck Sweater',
      price: 39.99,
      imageUrl: 'assets/images/FeatureProduct1.png',
      rating: 4.9,
      reviewsCount: 83,
      description:
      'Sportwear is no longer underculture, it is no longer indie or cobbled together as it once was.',
    ),
    Product(
      id: '2',
      title: 'Long Sleeve Dress',
      price: 45.00,
      imageUrl: 'assets/images/FeatureProduct2.png',
      rating: 4.8,
      reviewsCount: 42,
      description:
      'Elegant long sleeve dress suitable for casual and formal events.',
    ),
    Product(
      id: '3',
      title: 'Sportwear Set',
      price: 80.00,
      imageUrl: 'assets/images/FeatureProduct3.png',
      rating: 4.9,
      reviewsCount: 83,
      description:
      'Sportwear is no longer underculture, it is no longer indie or cobbled together as it once was. Sport is fashion today.',
    ),
    Product(
      id: '4',
      title: 'Rise Crop Hoodie',
      price: 43.00,
      imageUrl: 'assets/images/FeatureProduct4.png',
      rating: 4.7,
      reviewsCount: 56,
      description:
      'Comfortable crop hoodie perfect for training and casual daily wear.',
    ),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'GemStore',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 1. CATEGORII
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem(Icons.female, 'Women', isSelected: true),
                _buildCategoryItem(Icons.male, 'Men'),
                _buildCategoryItem(Icons.watch, 'Accessories'),
                _buildCategoryItem(Icons.face, 'Beauty'),
              ],
            ),
            const SizedBox(height: 20),

            // 2. BANNER PRINCIPAL (Autumn Collection)
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECE7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Autumn\nCollection\n2021',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: 140,
                      height: 160,
                      child: Image.asset(
                        'assets/images/HomeScreen1.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, size: 60, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. FEATURE PRODUCTS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Feature Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Show all', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featureProducts.length,
                itemBuilder: (context, index) {
                  final product = featureProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      margin: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 140,
                              height: 150,
                              child: Image.asset(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$ ${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 4. BANNER: HANG OUT & PARTY
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '| NEW COLLECTION',
                            style: TextStyle(fontSize: 11, color: Colors.grey, letterSpacing: 1),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'HANG OUT\n& PARTY',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: SizedBox(
                      width: 130,
                      height: 140,
                      child: Image.asset(
                        'assets/images/HangOutBanner.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, size: 50, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 5. RECOMMENDED
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recommended',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Show all', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRecommendedCard(
                    title: 'White fashion hoodie',
                    price: 29.00,
                    imagePath: 'assets/images/Recommended1.png',
                  ),
                  const SizedBox(width: 16),
                  _buildRecommendedCard(
                    title: 'Cotton T-Shirt',
                    price: 30.00,
                    imagePath: 'assets/images/Recommended2.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // 6. TOP COLLECTION
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Collection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Show all', style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Banner 1 Top Collection (FOR SLIM & BEAUTY)
            _buildTopCollectionBanner(
              subtitle: '| Sale up to 40%',
              title: 'FOR SLIM\n& BEAUTY',
              imagePath: 'assets/images/TopCollection1.png',
              height: 150,
            ),
            const SizedBox(height: 16),

            // Banner 2 Top Collection (Most sexy & fabulous)
            _buildTopCollectionBanner(
              subtitle: '| Summer Collection 2021',
              title: 'Most sexy\n& fabulous\ndesign',
              imagePath: 'assets/images/TopCollection2.png',
              height: 170,
            ),
            const SizedBox(height: 16),

            // Carduri alăturate (T-Shirts / Dresses)
            Row(
              children: [
                Expanded(
                  child: _buildSmallCollectionCard(
                    category: 'T-Shirts',
                    title: 'The\nOffice\nLife',
                    imagePath: 'assets/images/TopCollection3.png',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSmallCollectionCard(
                    category: 'Dresses',
                    title: 'Elegant\nDesign',
                    imagePath: 'assets/images/TopCollection4.png',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // WIDGETURI AJUTĂTOARE (HELPERS)

  Widget _buildCategoryItem(
      IconData icon,
      String label, {
        bool isSelected = false,
      }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: isSelected ? Colors.black : Colors.grey[100],
          child: Icon(icon, color: isSelected ? Colors.white : Colors.grey),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedCard({
    required String title,
    required double price,
    required String imagePath,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 54,
              height: 54,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCollectionBanner({
    required String subtitle,
    required String title,
    required String imagePath,
    required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: SizedBox(
              width: 140,
              height: height,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCollectionCard({
    required String category,
    required String title,
    required String imagePath,
  }) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}