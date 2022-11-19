class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJason(jsonData) {
    return LoginModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data: jsonData['data'] == null ? null : UserData.fromJson(jsonData['data']),
    );
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });

  factory UserData.fromJson(jsonData) {
    return UserData(
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      phone: jsonData['phone'],
      image: jsonData['image'],
      points: jsonData['points'],
      credit: jsonData['credit'],
      token: jsonData['token'],
    );
  }
}
