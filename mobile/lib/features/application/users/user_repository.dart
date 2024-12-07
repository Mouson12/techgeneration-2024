import 'dart:convert';

import 'package:office_app/features/application/core/user_client.dart';
import 'package:office_app/features/application/users/models/user_ranking.dart';

class UserRepository {
  Future<UserRanking?> getUserRanking(int month) async {
    UserClient client = UserClient();

    try {
      final response = await client.getRanking(month);

      final Map<String, dynamic> body = jsonDecode(response.body);
      return UserRanking.fromJson(body);
    } catch (e) {
      print("Exception! $e");
      return null;
    }
  }
}
