import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/shared_pref_service.dart';

class CartController extends ChangeNotifier { 
  final SharedPrefService _sharedPrefService = SharedPrefService();

  List<ProductModel> _cart = []; 
  List<ProductModel> get cart => _cart; 

  Future<void> loadCart() async { 
    final cartJson = await _sharedPrefService.getCart(); 
    _cart = cartJson
        .map((e) => ProductModel.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  bool isInCart(int id) { 
    return _cart.any((product) => product.id == id);
  }

  Future<void> toggleCartItem(ProductModel product) async { 
    if (isInCart(product.id)) {
      _cart.removeWhere((item) => item.id == product.id);
    } else {
      _cart.add(product);
    }

    await _saveCart(); 
    notifyListeners();
  }

  Future<void> _saveCart() async { 
    final cartJson = _cart.map((e) => jsonEncode(e.toMap())).toList();
    await _sharedPrefService.saveCart(cartJson); 
  }
}