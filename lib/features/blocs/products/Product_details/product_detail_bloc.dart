import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/Repository/product_repository.dart';
import 'package:ecommerce_app/data/models/product_detail_model.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository repository;
  ProductDetailBloc(this.repository) : super(ProductDetailInitial()) {
    on<LoadProductDetailEvent>((event, emit) async {
      emit(ProductDetailLoading());
      try {
        final product = await repository.fetchProductDetails(event.productId);
        emit(ProductDetailsLoaded(product));
      } catch (e) {
        emit(ProductDetailError(e.toString()));
      }
    });
  }
}
