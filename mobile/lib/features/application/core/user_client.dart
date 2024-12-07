import 'package:office_app/features/application/core/base_client.dart';
import 'package:office_app/features/application/core/user_client_path.dart';

class UserClient extends BBBaseClient {
  Future<dynamic> getRanking(int month) async {
    final response = await get(UserClientPath.ranking(month));
    return response;
  }

  Future<int> logIn(Map<String, String> headers) async {
    final response = await getHeaders(UserClientPath.time(), headers);
    return response.statusCode;
  }

  Future<dynamic> getCurrentUserMeasurements(
      Map<String, String> headers) async {
    final response = await getHeaders(UserClientPath.measurements(), headers);
    return response;
  }
}
