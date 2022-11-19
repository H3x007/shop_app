class ChangeCartModel {
  bool? status;
  String? message;

  ChangeCartModel.fromJson(Map<String, dynamic> jsonData){
    status = jsonData['status'];
    message = jsonData['message'];
  }
}