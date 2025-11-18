import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  //final Dio _dio = Dio();
  final String _baseUrl = 'https://fakestoreapi.com';

  //static const String _baseUrl = 'https://fakestoreapi.com';

  Future<List<ProductModel>> fetchTopProduct() async {
    final String fullUrl = '$_baseUrl/products';
    final response = await http.get(Uri.parse(fullUrl));

    ///top/Product
    if (response.statusCode == 200) {
      final List products = jsonDecode(response.body);
      return products.map((v) => ProductModel.fromJson(v)).toList();
    } else {
      throw Exception("Gagal Fetch Api");
    }
  }
}
