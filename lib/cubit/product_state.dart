import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {}
class ProductEmpty extends ProductState {}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
  @override
  List<Object?> get props => [message];
}
class ProductSuccess extends ProductState {
  final List<Product> allProducts;
  final List<Product> displayedProducts;
  ProductSuccess(this.allProducts, this.displayedProducts);
  @override
  List<Object?> get props => [allProducts, displayedProducts];
}