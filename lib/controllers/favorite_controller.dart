import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/shared_pref_service.dart';

class FavoriteController extends ChangeNotifier {
  final SharedPrefService _sharedPrefService = SharedPrefService();

  List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => _favorites;

  Future<void> loadFavorites() async {
    final favoritesJson = await _sharedPrefService.getFavorites();
    _favorites = favoritesJson
        .map((e) => ProductModel.fromMap(jsonDecode(e) as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }

  bool isFavorite(int id) {
    return _favorites.any((product) => product.id == id);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (isFavorite(product.id)) {
      _favorites.removeWhere((item) => item.id == product.id);
    } else {
      _favorites.add(product);
    }

    await _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final favoritesJson = _favorites.map((e) => jsonEncode(e.toMap())).toList();
    await _sharedPrefService.saveFavorites(favoritesJson);
  }
}
