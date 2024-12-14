import 'dart:convert'; // For decoding JSON data
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:office_app/features/data/core/api_path.dart';
import 'package:office_app/features/data/models/sensor_model.dart';

part 'sensor_state.dart';

class SensorCubit extends Cubit<SensorState> {
  SensorCubit() : super(SensorInitial());

  Future<void> loadData() async {
    emit(SensorLoading());

    try {
      // Fetch data for Pulsometr
      final pulsometrResponse =
          await http.get(Uri.parse('${ApiPath.path}/api/Pulsometr'));

      // Fetch data for Temperature
      final temperatureResponse =
          await http.get(Uri.parse('${ApiPath.path}/api/temperature'));

      // Check if both requests were successful
      if (pulsometrResponse.statusCode == 200 &&
          temperatureResponse.statusCode == 200) {
        // Decode the response body as JSON
        final pulsometrData = json.decode(pulsometrResponse.body);
        final temperatureData = json.decode(temperatureResponse.body);

        // Convert the JSON data into SensorModel
        final pulsometrSensor = SensorModel.fromJson(pulsometrData);
        final temperatureSensor = SensorModel.fromJson(temperatureData);

        // Combine both sensors into a map (or list depending on how you want to manage them)
        final combinedSensors = {
          'pulsometer': pulsometrSensor,
          'temperature': temperatureSensor,
        };

        // Emit the loaded state with both sensors data
        emit(SensorLoaded(combinedSensors));
      } else {
        // Handle error if one of the requests fails
        emit(SensorError('Failed to load sensor data'));
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      emit(SensorError('An error occurred: $e'));
    }
  }

  Future<void> reloadData() async {
    print("Sensor data reload");
    try {
      // Fetch data for Pulsometr
      final pulsometrResponse =
          await http.get(Uri.parse('${ApiPath.path}/api/Pulsometr'));

      // Fetch data for Temperature
      final temperatureResponse =
          await http.get(Uri.parse('${ApiPath.path}/api/temperature'));

      // Check if both requests were successful
      if (pulsometrResponse.statusCode == 200 &&
          temperatureResponse.statusCode == 200) {
        // Decode the response body as JSON
        final pulsometrData = json.decode(pulsometrResponse.body);
        final temperatureData = json.decode(temperatureResponse.body);

        // Convert the JSON data into SensorModel
        final pulsometrSensor = SensorModel.fromJson(pulsometrData);
        final temperatureSensor = SensorModel.fromJson(temperatureData);

        // Combine both sensors into a map (or list depending on how you want to manage them)
        final combinedSensors = {
          'pulsometer': pulsometrSensor,
          'temperature': temperatureSensor,
        };

        // Emit the loaded state with both sensors data
        emit(SensorLoaded(combinedSensors));
      } else {}
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
