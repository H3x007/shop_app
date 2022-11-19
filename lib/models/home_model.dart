class HomeModel {
  bool? status;
  HomeModelData? data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(jsonData){
    return HomeModel(status: jsonData['status'], data: HomeModelData.fromJson(jsonData['data']));
  }
}

class HomeModelData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeModelData.fromJson(Map<String, dynamic> jsonData){
    jsonData['banners'].forEach((element){
      banners.add(BannersModel.fromJson(element));
    });
    jsonData['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  final int id;
  final String image;

  BannersModel({required this.id, required this.image});
  factory BannersModel.fromJson(jsonData) {
    return BannersModel(
      id: jsonData['id'],
      image: jsonData['image'],
    );
  }
}

class ProductsModel {
  final int id;
  final dynamic price;
  final dynamic old_price;
  final dynamic discount;
  final String image;
  final String name;
  final String description;
  final bool in_favorites;
  final bool in_cart;

  ProductsModel({
    required this.id,
    required this.price,
    required this.old_price,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.in_favorites,
    required this.in_cart,
  });
  factory ProductsModel.fromJson(jsonData) {
    return ProductsModel(
        id: jsonData['id'],
        price: jsonData['price'],
        old_price: jsonData['old_price'],
        discount: jsonData['discount'],
        image: jsonData['image'],
        name: jsonData['name'],
        description: jsonData['description'],
        in_favorites: jsonData['in_favorites'],
        in_cart: jsonData['in_cart']);
  }
}
