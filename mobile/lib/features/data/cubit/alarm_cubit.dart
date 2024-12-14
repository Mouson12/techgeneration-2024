import 'dart:convert';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_app/features/data/core/api_path.dart';
import 'package:office_app/features/data/models/alert_model.dart';

part 'alarm_state.dart';

class AlarmCubit extends Cubit<AlarmState> {
  AlarmCubit() : super(AlarmInitial());

  Future<void> loadData() async {
    emit(AlarmLoading());

    try {
      // Fetch data from the Alarm API
      final response = await http.get(Uri.parse('${ApiPath.path}/api/alarm'));

      if (response.statusCode == 200) {
        // Decode the response body as JSON
        final data = json.decode(response.body);

        // Convert the JSON data into AlertModel
        final alert = AlertModel.fromJson(data);

        // Emit the loaded state with the AlertModel
        emit(AlarmLoaded(alert));
        print("alarm: ${alert.isDanger}");
      } else {
        // Handle error if the request fails
        emit(AlarmError('Failed to load alarm data'));
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      emit(AlarmError('An error occurred: $e'));
    }
  }
}
