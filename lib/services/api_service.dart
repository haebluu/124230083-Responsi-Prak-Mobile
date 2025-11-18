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


//   Future<List<ProductModel>> fetchTopProduct() async {
//     try {
//       final response = await _dio.get('$_baseUrl/products');

//       ///top/Product
//       if(response.statusCode == 200){
//         final data = jsonDecode(response.body);
//         List products = data['data'];
//         return products.map((v) => ProductModel.fromJson(v)).toList();
//       }else{
//         throw Exception("Gagal Fetch Api");
//       }
//     //   if (response.statusCode == 200) {
//     //     final List<dynamic> data = response.data; //['data']
//     //     return data.map((json) => ProductModel.fromJson(json)).toList();
//     //   } else {
//     //     throw Exception('Failed to load top Product');
//     //   }
//     // } on DioException catch (e) {
//     //   throw Exception('Failed to connect to API: ${e.message}');
//     // } catch (e) {
//     //   rethrow;
//     }
//   }
// }


