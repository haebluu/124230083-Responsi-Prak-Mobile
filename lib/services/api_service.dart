import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ApiService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchTopProduct() async {
    try {
      final response = await _dio.get('$_baseUrl/products');

      ///top/Product
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top Product');
      }
    } on DioException catch (e) {
      throw Exception('Failed to connect to API: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
