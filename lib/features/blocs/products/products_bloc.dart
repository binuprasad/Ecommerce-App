import 'package:ecommerce_app/data/Repository/product_repository.dart';
import 'package:ecommerce_app/data/models/product_listing_model.dart';
import 'package:ecommerce_app/features/blocs/products/products_event.dart';
import 'package:ecommerce_app/features/blocs/products/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  static const int limit = 10;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProductsEvent>(_loadProducts);
  }

  Future<void> _loadProducts(
      LoadProductsEvent event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductInitial) {
        emit(ProductLoading());

        final response =
            await repository.fetchProducts(limit: limit, skip: 0);

        emit(ProductLoaded(
          products: response.products,
          skip: limit,
          hasMore: response.products.length == limit,
        ));
        return;
      }

      if (state is ProductLoaded) {
        final current = state as ProductLoaded;

        if (!current.hasMore) return;

        final response = await repository.fetchProducts(
            limit: limit, skip: current.skip);

        emit(current.copyWith(
          products: [...current.products, ...response.products],
          skip: current.skip + limit,
          hasMore: response.products.length == limit,
        ));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
