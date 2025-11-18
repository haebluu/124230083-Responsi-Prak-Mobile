import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/cart_controller.dart'; 
import 'detail_page.dart';

class CartPage extends StatelessWidget { 
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Provider.of<CartController>(context); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'), 
        backgroundColor: Color.fromRGBO(206, 1, 88, 1),
      ),
      body: cartController.cart.isEmpty 
          ? const Center(
              child: Text(
                'No items added to cart yet.', 
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cartController.cart.length,
              itemBuilder: (context, index) {
                final product = cartController.cart[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      leading: SizedBox(
                        width: 60,
                        height: 90,
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.broken_image),
                        ),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Price: \$${product.price?.toStringAsFixed(2) ?? '-'}'), 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(product: product),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}