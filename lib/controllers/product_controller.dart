import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ProductModel> _topProduct = [];
  List<ProductModel> get topProduct => _topProduct;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTopProduct() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _topProduct = await _apiService.fetchTopProduct();
    } catch (e) {
      _errorMessage = 'Failed to load data: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
