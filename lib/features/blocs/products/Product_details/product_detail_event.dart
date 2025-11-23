part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetailEvent extends ProductDetailEvent {
  final int productId;

  const LoadProductDetailEvent(this.productId);

  @override
  List<Object> get props => [productId];
}
