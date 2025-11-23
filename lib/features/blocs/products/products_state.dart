import 'package:ecommerce_app/data/models/product_listing_model.dart';
import 'package:equatable/equatable.dart';




abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final int skip;
  final bool hasMore;

  ProductLoaded({
    required this.products,
    required this.skip,
    required this.hasMore,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    int? skip,
    bool? hasMore,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      skip: skip ?? this.skip,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [products, skip, hasMore];
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
