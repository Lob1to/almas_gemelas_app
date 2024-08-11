import '../../domain/entities/user.dart';

class UserMapper {
  static User fromUserJsonToEntity(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        emailValidated: json['emailValidated'],
        role: json['role'],
        userImg: json['userImg'],
        refreshToken: json['refreshToken'],
        accessToken: json['accessToken'],
      );
}
