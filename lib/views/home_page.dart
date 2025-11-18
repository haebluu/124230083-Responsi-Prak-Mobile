import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart'; 
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSnackBar(BuildContext context, bool isInCart) { 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isInCart ? 'Removed from Cart' : 'Added to Cart'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, dynamic product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productController =
        Provider.of<ProductController>(context); 

    return Scaffold(
      appBar: AppBar(
        title:  Text('Product'),
        backgroundColor: Color.fromRGBO(206, 1, 88, 1),
      ),
      body: productController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productController.errorMessage != null
              ? Center(child: Text('Error: ${productController.errorMessage}'))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio:
                          0.65, 
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: productController.topProduct.length,
                    itemBuilder: (context, index) {
                      final product = productController.topProduct[index];
                      return Consumer<CartController>( 
                        builder: (context, cartController, child) { 
                          final isInCart =
                              cartController.isInCart(product.id); 

                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () => _navigateToDetail(context, product),
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: product.image,
                                        fit: BoxFit.fitWidth,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2)),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.broken_image,
                                                size: 50),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          product.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '\$${product.price?.toStringAsFixed(2) ?? '-'}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(206, 1, 88, 1)), 
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.toggleCartItem(product);
                                                _showSnackBar(context, isInCart);
                                              },
                                              child: Icon(
                                                isInCart
                                                    ? Icons.shopping_cart
                                                    : Icons.shopping_cart_outlined,
                                                color: isInCart
                                                    ? Colors.orange
                                                    : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 14),
                                            const SizedBox(width: 4),
                                            Text('${product.rate?.toStringAsFixed(1) ?? '-'} | Stock: ${product.count ?? '-'}',
                                                style: const TextStyle(
                                                    fontSize: 10, color: Colors.grey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}