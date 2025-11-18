class ProductModel {
  final int id;
  final String title;
  final double? price;
  final String image;
  final String description;
  final double? rate;
  final int? count;

  ProductModel({
    required this.id,
    required this.title,
    this.price,
    required this.image,
    required this.description,
    this.rate,
    this.count,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] as Map<String, dynamic>?;

    return ProductModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'No Title',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? 'Tidak ada deskripsi',
      rate: (ratingJson?['rate'] as num?)?.toDouble() ?? 0.0,
      count: ratingJson?['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'rate': rate,
      'count': count,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: (map['id'] is int)
          ? map['id']
          : int.tryParse(map['id'].toString()) ?? 0,
      title: map['title'] ?? '',
      price: (map['price'] is num)
          ? (map['price'] as num).toDouble()
          : double.tryParse(map['price'].toString()) ?? 0.0,
      image: map['image'] ?? '',
      rate: (map['rate'] is num)
          ? (map['rate'] as num).toDouble()
          : double.tryParse(map['rate'].toString()) ?? 0.0,
      description: map['description'] ?? '',
      count: (map['count'] is int)
          ? map['count']
          : int.tryParse(map['count'].toString()),
    );
  }
}