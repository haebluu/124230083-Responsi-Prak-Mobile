import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product_model.dart';
import '../controllers/favorite_controller.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Provider.of<FavoriteController>(context);
    final isFavorite = favoriteController.isFavorite(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: Color.fromRGBO(206, 1, 88, 1),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              favoriteController.toggleFavorite(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isFavorite
                      ? 'Removed from Favorites'
                      : 'Added to Favorites'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // --- Poster dan Judul ---
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
                  product.price! as String,
                  style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
              ),
            const SizedBox(height: 10),

            // --- Score ---
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 26),
                  const SizedBox(width: 5),
                  Text(
                    ' ${product.rate!}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- Detail Tambahan ---
            const Text(
              'Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // _buildInfoRow('Type', product.type),
            // _buildInfoRow('Episodes', product.episodes?.toString()),
            // _buildInfoRow('Rating', product.rating),
            // _buildInfoRow('Status', product.status),
            // _buildInfoRow('Year', product.year?.toString()),
            // _buildInfoRow('Genres', product.genres.join(', ')),

            const SizedBox(height: 20),

            // --- Sinopsis ---
            const Text(
              'description',
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
