import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/product_controller.dart';
import '../controllers/favorite_controller.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showSnackBar(BuildContext context, bool isFavorite) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorite ? 'Removed from Favorites' : 'Added to Favorites'),
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
        Provider.of<ProductController>(context); //ini A besar

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top product'),
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
                          0.65, // <-- Dikurangi menjadi 0.65 (tinggi lebih pendek)
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: productController.topProduct.length,
                    itemBuilder: (context, index) {
                      final product = productController
                          .topProduct[index]; //yang ada topnya itu Anya besar
                      return Consumer<FavoriteController>(
                        builder: (context, favoriteController, child) {
                          final isFavorite =
                              favoriteController.isFavorite(product.id);

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
                                  // Gambar Poster
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

                                  // Detail product
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // Gunakan MainAxisSize.min agar Column tidak mencoba mengisi tinggi Card
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
                                            const Icon(Icons.star,
                                                color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                                product.rate as String,
                                                //.toStringAsFixed(2),
                                                style: const TextStyle(
                                                    fontSize: 12)),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                favoriteController
                                                    .toggleFavorite(product);
                                                _showSnackBar(
                                                    context, isFavorite);
                                              },
                                              child: Icon(
                                                isFavorite
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: isFavorite
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Type: ${product.price ?? '-'} | Count: ${product.count ?? '-'}',
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.grey),
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
