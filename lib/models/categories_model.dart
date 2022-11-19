// class CategoriesModel {
//   bool? status;
//   CategoriesDataModel? data;
//   CategoriesModel({required this.status, required this.data});
//   factory CategoriesModel.fromJson(Map<String, dynamic> jsonData){
//     return CategoriesModel(status: jsonData['status'], data: jsonData['data']);
//   }
// }
//
// class CategoriesDataModel {
//   int? currentPage;
//   List<DataModel> data = [];
//   CategoriesDataModel.fromJson(jsonData){
//     currentPage = jsonData['current_page'];
//     jsonData['data'].forEach((element) {
//       data.add(DataModel.fromJson(jsonData['data']));
//     });
//   }
//
// }
//
// class DataModel {
//   int? id;
//   int? name;
//   int? image;
//
//   DataModel({required this.id, required this.name, required this.image});
//
//   DataModel.fromJson(Map<String, dynamic> jsonData) {
//     id = jsonData['id'];
//     name = jsonData['name'];
//     image = jsonData['image'];
//   }
// }


class CategoriesModel {
  bool ?status;
  CategoriesDataModel ?data;

  CategoriesModel.formJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  int ?current_page;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.formJson(element));
    });
  }

}

class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.formJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}