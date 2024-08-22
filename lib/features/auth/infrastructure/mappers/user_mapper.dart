import '../../domain/entities/user.dart';

class UserMapper {
  static User fromUserJsonToEntity(Map<String, dynamic> json) {
    final jsonData = json['data'];
    final jsonUser = jsonData['user'];

    final jsonRole = jsonUser['role'] as List<dynamic>;
    final role = jsonRole.map((e) => e.toString()).toList();

    final user = User(
      id: jsonUser['id'],
      name: jsonUser['name'],
      email: jsonUser['email'],
      emailValidated: jsonUser['emailValidated'],
      role: role,
      userImg: jsonUser['img'],
      refreshToken: jsonUser['refreshToken'],
      accessToken: jsonData['token'],
    );

    return user;
  }
}
