class User {
  final String id;
  final String name;
  final String email;
  final bool emailValidated;
  final List<String> role;
  final String userImg;
  final String refreshToken;
  final String accessToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailValidated,
    required this.role,
    required this.userImg,
    required this.refreshToken,
    required this.accessToken,
  });
}
