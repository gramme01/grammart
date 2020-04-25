import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grammart/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  static const String productServer =
      'https://flutter-shop-app-22b2b.firebaseio.com/products';

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = '$productServer/$id.json?auth=$token';

    final resp = await http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );
    if (resp.statusCode >= 400) {
      _setFavValue(oldStatus);
      throw HttpException('Could not add Favorite');
    }
  }
}
