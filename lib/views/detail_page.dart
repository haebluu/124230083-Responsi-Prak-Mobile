// File: lib/views/detail_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart'; 

class DetailPage extends StatelessWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, child) {
        final isInCart = cartController.isInCart(product.id);
        
        final buttonColor = isInCart ? Colors.orange : Colors.blue; 
        final buttonText = isInCart ? 'Added to Cart' : 'Add to Cart';

        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
            backgroundColor: Color.fromRGBO(206, 1, 88, 1),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    height: 300,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.broken_image,
                      size: 300,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                if (product.price != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Price: \$${product.price!.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 10),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 26),
                      const SizedBox(width: 5),
                      Text(
                        ' ${product.rate?.toStringAsFixed(1) ?? '-'}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      cartController.toggleCartItem(product); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isInCart 
                              ? 'Removed from Cart'
                              : 'Added to Cart'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    label: Text( 
                      buttonText, 
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // _buildInfoRow('Type', product.type),
                // _buildInfoRow('Episodes', product.episodes?.toString()),
                // _buildInfoRow('Rating', product.rating),
                // _buildInfoRow('Status', product.status),
                // _buildInfoRow('Year', product.year?.toString()),
                // _buildInfoRow('Genres', product.genres.join(', ')),

                const SizedBox(height: 20),

                const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty || value == '0')
      return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}