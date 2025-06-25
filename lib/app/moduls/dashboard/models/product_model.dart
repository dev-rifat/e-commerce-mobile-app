class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String? icon; // optional

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.icon,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
      icon: json['icon'],
    );
  }
}
