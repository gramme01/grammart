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

  static const String favServer =
      'https://flutter-shop-app-22b2b.firebaseio.com/userFavorites';

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = '$favServer/$userId/$id.json?auth=$token';

    final resp = await http.put(
      url,
      body: json.encode(isFavorite),
    );
    if (resp.statusCode >= 400) {
      _setFavValue(oldStatus);
      throw HttpException('Could not add Favorite');
    }
  }
}
