class ProductModel {
  final int malId;
  final String title;
  final double? price;
  final String image;
  final double rating;
  final String description;
  final double? rate;
  final int? count;
  // final String? rating;
  // final String? status;
  // final int? year;
  // final List<String> genres;
  // final String? trailerUrl;

  ProductModel({
    required this.malId,
    required this.title,
    this.price,
    required this.image,
    required this.rating,
    required this.description,
    this.rate,
    this.count,
    // this.rating,
    // this.status,
    // this.year,
    // this.genres = const [],
    // this.trailerUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      malId: json['mal_id'] ?? 0,
      title: json['title'] ?? json['title_english'] ?? 'No Title',
      price: json['title_english'],
      image: json['images']?['jpg']?['image_url'] ?? '',
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 0.0,
      description: json['description'] ?? 'Tidak ada sinopsis.',
      rate: json['rate'],
      count: json['count'],
      // rating: json['rating'],
      // status: json['status'],
      // year: json['year'],
      // genres: (json['genres'] is List)
      //     ? (json['genres'] as List)
      //         .map((g) => g['name'].toString())
      //         .toList()
      //     : [],
      // trailerUrl: json['trailer']?['embed_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mal_id': malId,
      'title': title,
      'title_english': price,
      'image_url': image,
      'rating': rating,
      'description': description,
      'rate': rate,
      'count': count,
      // 'rating': rating,
      // 'status': status,
      // 'year': year,
      // 'genres': genres.join(', '),
      // 'trailer_url': trailerUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      malId: (map['mal_id'] is int)
          ? map['mal_id']
          : int.tryParse(map['mal_id'].toString()) ?? 0,
      title: map['title'] ?? '',
      price: map['title_english'],
      image: map['image_url'] ?? '',
      rating: (map['rating'] is num)
          ? (map['rating'] as num).toDouble()
          : double.tryParse(map['rating'].toString()) ?? 0.0,
      description: map['description'] ?? '',
      rate: map['rate'],
      count: (map['count'] is int)
          ? map['count']
          : int.tryParse(map['count'].toString()),
      // rating: map['rating'],
      // status: map['status'],
      // year: (map['year'] is int)
      //     ? map['year']
      //     : int.tryParse(map['year'].toString()),
      // genres: (map['genres'] != null)
      //     ? map['genres'].toString().split(',').map((e) => e.trim()).toList()
      //     : [],
      // trailerUrl: map['trailer_url'],
    );
  }
}
