class ProductColor {
  final String id;
  final String name;
  final String hexValue;

  ProductColor({required this.id, required this.name, required this.hexValue});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      id: json['id'],
      name: json['name'],
      hexValue: json['value'],
    );
  }
}

class Review {
  final String id;
  final String author;
  final String avatarUrl;
  final double rating;
  final String createdAtLabel;
  final String text;

  Review({
    required this.id,
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.createdAtLabel,
    required this.text,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      author: json['author'],
      avatarUrl: json['avatarUrl'],
      rating: (json['rating'] as num).toDouble(),
      createdAtLabel: json['createdAtLabel'],
      text: json['text'],
    );
  }
}

class RatingBreakdown {
  final int stars;
  final int percentage;

  RatingBreakdown({required this.stars, required this.percentage});

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return RatingBreakdown(
      stars: json['stars'],
      percentage: json['percentage'],
    );
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;
  final bool isFavorite;

  final List<String>? galleryImageUrls;
  final double? rating;
  final int? ratingCount;
  final int? reviewCount;
  final String? description;

  final List<ProductColor>? availableColors;
  final List<String>? availableSizes;
  final Map<String, bool>? sizeAvailability;

  final List<RatingBreakdown>? ratingBreakdown;
  final List<Review>? reviews;
  final List<Product>? similarProducts;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
    this.isFavorite = false,
    this.galleryImageUrls,
    this.rating,
    this.ratingCount,
    this.reviewCount,
    this.description,
    this.availableColors,
    this.availableSizes,
    this.sizeAvailability,
    this.ratingBreakdown,
    this.reviews,
    this.similarProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] ?? 'USD',
      imageUrl: json['mainImageUrl'] ?? json['imageUrl'] ?? '',

      galleryImageUrls: json['galleryImageUrls'] != null
          ? List<String>.from(json['galleryImageUrls']) : null,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      ratingCount: json['ratingCount'],
      reviewCount: json['reviewCount'],
      description: json['description'],

      availableColors: json['availableColors'] != null
          ? (json['availableColors'] as List).map((i) => ProductColor.fromJson(i)).toList() : null,
      availableSizes: json['availableSizes'] != null
          ? List<String>.from(json['availableSizes']) : null,
      sizeAvailability: json['sizeAvailability'] != null
          ? Map<String, bool>.from(json['sizeAvailability']) : null,

      ratingBreakdown: json['ratingBreakdown'] != null
          ? (json['ratingBreakdown'] as List).map((i) => RatingBreakdown.fromJson(i)).toList() : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList() : null,

      similarProducts: json['similarProducts'] != null
          ? (json['similarProducts'] as List).map((i) => Product.fromJson(i)).toList() : null,
    );
  }

  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      galleryImageUrls: galleryImageUrls,
      rating: rating,
      ratingCount: ratingCount,
      reviewCount: reviewCount,
      description: description,
      availableColors: availableColors,
      availableSizes: availableSizes,
      sizeAvailability: sizeAvailability,
      ratingBreakdown: ratingBreakdown,
      reviews: reviews,
      similarProducts: similarProducts,
    );
  }
}