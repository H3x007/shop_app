class ChangeFavoritesModel {
  bool? status;
  String? message;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
  }
}