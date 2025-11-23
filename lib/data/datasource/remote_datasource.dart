import 'package:ecommerce_app/core/dio_client.dart';
import 'package:ecommerce_app/data/models/product_detail_model.dart';
import 'package:ecommerce_app/data/models/product_listing_model.dart';

class ProductRemoteDataSource {
  Future<ProductResponse> getProducts(int limit, int skip) async {
    final response = await DioClient.dio.get(
      "",
      queryParameters: {"limit": limit, "skip": skip},
    );
    return ProductResponse.fromJson(response.data);
  }

  Future<ProductDetailResponse> getProductDetails(int id) async {
    final response = await DioClient.dio.get('/$id');
    return ProductDetailResponse.fromJson(response.data);
  }
}
