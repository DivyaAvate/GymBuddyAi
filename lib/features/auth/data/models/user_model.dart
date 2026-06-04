class UserModel {
  final String id;
  final String name;   
  final String email;
  final String? displayName;
  final String? accessToken;

  UserModel({required this.id, required this.email, this.displayName, this.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'].toString(),
      email: json['user']['email'],
      displayName: json['user']['displayName'],
      accessToken: json['accessToken'],
    );
  }
}