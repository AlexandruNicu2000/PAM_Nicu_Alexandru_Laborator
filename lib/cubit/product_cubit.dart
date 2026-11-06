import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductLoading());

  void loadProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.fetchProducts();
      if (products.isEmpty) {
        emit(ProductEmpty());
      } else {
        emit(ProductSuccess(products, products));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;
      final filtered = currentState.allProducts
          .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(filtered.isEmpty ? ProductEmpty() : ProductSuccess(currentState.allProducts, filtered));
    }
  }

  void sortProducts(String criteria) {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;
      final sorted = List<Product>.from(currentState.displayedProducts);

      if (criteria == 'price_asc') {
        sorted.sort((a, b) => a.price.compareTo(b.price));
      } else if (criteria == 'price_desc') {
        sorted.sort((a, b) => b.price.compareTo(a.price));
      } else if (criteria == 'name_asc') {
        sorted.sort((a, b) => a.name.compareTo(b.name));
      }

      emit(ProductSuccess(currentState.allProducts, sorted));
    }
  }

  void toggleFavorite(String id) {
    if (state is ProductSuccess) {
      final currentState = state as ProductSuccess;

      final updatedAll = currentState.allProducts.map((p) {
        return p.id == id ? p.copyWith(isFavorite: !p.isFavorite) : p;
      }).toList();

      final updatedDisplayed = currentState.displayedProducts.map((p) {
        return p.id == id ? p.copyWith(isFavorite: !p.isFavorite) : p;
      }).toList();

      emit(ProductSuccess(updatedAll, updatedDisplayed));
    }
  }
}