import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      final String response = await rootBundle.loadString('assets/lab_v1.json');
      final Map<String, dynamic> data = json.decode(response);

      final homePage = data['homePage'];
      final List<dynamic> featureProducts = homePage['featureProducts'];
      final List<dynamic> recommended = homePage['recommended'];
      final List<dynamic> allProductsJson = [...featureProducts, ...recommended];

      final Map<String, dynamic>? detailedProductJson = data['productPage']?['product'];

      List<Product> finalProductsList = [];

      for (var itemJson in allProductsJson) {
        if (detailedProductJson != null && itemJson['id'] == detailedProductJson['id']) {
          finalProductsList.add(Product.fromJson(detailedProductJson));
        } else {
          finalProductsList.add(Product.fromJson(itemJson));
        }
      }

      return finalProductsList;
    } catch (e) {
      throw Exception('Eroare la procesarea lab_v1.json: $e');
    }
  }
}