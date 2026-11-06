import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Women';
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: isSearching
            ? IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            setState(() {
              isSearching = false;
              searchController.clear();
            });
            context.read<ProductCubit>().searchProducts('');
          },
        )
            : IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: isSearching
            ? TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            context.read<ProductCubit>().searchProducts(query);
          },
        )
            : const Text(
          'GemStore',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: !isSearching,
        actions: [
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.black),
            onSelected: (String criteria) {
              context.read<ProductCubit>().sortProducts(criteria);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'price_asc',
                child: Text('Price: Low to High'),
              ),
              const PopupMenuItem<String>(
                value: 'price_desc',
                child: Text('Price: High to Low'),
              ),
              const PopupMenuItem<String>(
                value: 'name_asc',
                child: Text('Name: A - Z'),
              ),
            ],
          ),

          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          List featureProducts = [];
          if (state is ProductSuccess) {
            featureProducts = state.displayedProducts;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(Icons.female, 'Women'),
                    _buildCategoryItem(Icons.male, 'Men'),
                    _buildCategoryItem(Icons.watch, 'Accessories'),
                    _buildCategoryItem(Icons.face, 'Beauty'),
                  ],
                ),
                const SizedBox(height: 20),

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
                          child: Image.network(
                            'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=400&q=80',
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Feature Products',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ProductCubit>().searchProducts('');
                      },
                      child: const Text('Show all', style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (state is ProductEmpty || featureProducts.isEmpty)
                  Container(
                    height: 230,
                    alignment: Alignment.center,
                    child: const Text('No products match your criteria.', style: TextStyle(color: Colors.grey)),
                  )
                else
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
                                    child: Image.network(
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
                                  product.name,
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
                // Restul ecranului (alte bannere, recomandări statice) pot continua aici
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    bool isSelected = selectedCategory == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = label;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category $label selected'), duration: const Duration(milliseconds: 500)),
        );
      },
      child: Column(
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
      ),
    );
  }
}