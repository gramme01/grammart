import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // receives the id

    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
