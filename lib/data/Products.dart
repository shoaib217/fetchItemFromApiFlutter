// ignore_for_file: public_member_api_docs, sort_constructors_first

class Products {
  int limit;
  int skip;
  int total;
  List<Product>? products;

  Products(
      {required this.limit,
      required this.skip,
      required this.total,
      required this.products});

  factory Products.fromJson(Map<String, dynamic> json) {
    var dynamicLists = json["products"] as List<dynamic>;
    var productList = dynamicLists.map((dynamicData) {
      var dynamicImageList = dynamicData["images"] as List<dynamic>;
      var images = dynamicImageList.map((image) {
        return image.toString();
      },).toList();

      return Product(
          brand: dynamicData["brand"] as String,
          category: dynamicData["category"] as String,
          description: dynamicData["description"] as String,
          discountPercentage: dynamicData["discountPercentage"] as double,
          id: dynamicData["id"] as int,
          images: images,
          price: dynamicData["price"] as int,
          rating: double.parse(dynamicData["rating"].toString()),
          stock: dynamicData["stock"] as int,
          thumbnail: dynamicData["thumbnail"] as String,
          title: dynamicData["title"] as String);
    }).toList();
    return Products(
        limit: json["limit"],
        skip: json["skip"],
        total: json["total"],
        products: productList);
  }
}

class Product {
  String brand;
  String category;
  String description;
  double discountPercentage;
  int id;
  List<String> images;
  int price;
  double rating;
  int stock;
  String thumbnail;
  String title;
  Product({
    required this.brand,
    required this.category,
    required this.description,
    required this.discountPercentage,
    required this.id,
    required this.images,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.title,
  });
}
