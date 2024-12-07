import 'package:office_app/features/application/users/models/user.dart';

class UserRanking {
  final List<User> users;

  UserRanking({required this.users});

  factory UserRanking.fromJson(Map<String, dynamic> json) {
    final List<dynamic> ranking = json['ranking'];
    final List<User> users = ranking
        .map((userJson) => User.fromJson(userJson))
        .toList(); // Convert each user JSON to User object
    return UserRanking(users: users);
  }
}
