import 'package:ecommerce_app/data/datasource/remote_datasource.dart';
import 'package:ecommerce_app/data/models/product_detail_model.dart';
import 'package:ecommerce_app/data/models/product_listing_model.dart';

class ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepository(this.remoteDataSource);

  Future<ProductResponse> fetchProducts({int limit = 10, int skip = 0}) =>
      remoteDataSource.getProducts(limit, skip);

  Future<ProductDetailResponse> fetchProductDetails(int id) =>
      remoteDataSource.getProductDetails(id);
}
