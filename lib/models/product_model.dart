class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String sku;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sku,
  });

  factory Product.dummy() {
    return Product(
      id: '1',
      name: 'Macbook Pro M4',
      description: 'Macbook Pro M4 2025',
      price: 490.0,
      imageUrl: 'https://www.digitaltrends.com/wp-content/uploads/2024/11/macbook-pro-m4-pro-01.jpg',
      sku: 'SA-12436',
    );
  }

  static List<Product> get dummyProducts => [
    Product(
      id: '1',
      name: 'Macbook Pro M4',
      description: 'Macbook Pro M4 2025',
      price: 490.0,
      imageUrl: 'https://www.digitaltrends.com/wp-content/uploads/2024/11/macbook-pro-m4-pro-01.jpg',
      sku: 'SA-12436',
    ),
    Product(
      id: '2',
      name: 'iPhone 15 Pro',
      description: 'Latest iPhone with amazing features',
      price: 1200.0,
      imageUrl: 'https://media.wired.com/photos/6508bcf4b6194ea7054252b7/master/w_2240,c_limit/iPhone-15-Review-Top-Gear.jpg',
      sku: 'IP-15678',
    ),
    Product(
      id: '3',
      name: 'Samsung TV',
      description: '55 inch 4K Smart TV',
      price: 800.0,
      imageUrl: 'https://cdn.thewirecutter.com/wp-content/media/2023/09/lcdledtv-2048px-tclQM8-2109-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
      sku: 'ST-98765',
    ),
  ];
}