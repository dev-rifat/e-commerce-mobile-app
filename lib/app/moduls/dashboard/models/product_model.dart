class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category;
  final String? icon;
  int quantity = 1; // <-- add this

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.icon,
    this.quantity = 1,
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
