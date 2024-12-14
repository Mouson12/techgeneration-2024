import 'dart:convert'; // For decoding JSON data
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http; // For making HTTP requests
import 'package:office_app/features/data/core/api_path.dart';
import 'package:office_app/features/data/models/medication._model.dart';

part 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationInitial());

  Future<void> loadData() async {
    emit(MedicationLoading());

    try {
      // Make the HTTP request
      final response =
          await http.get(Uri.parse('${ApiPath.path}/api/medications'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the response body as JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Convert the JSON into a MedicationModel
        final medication = MedicationModel.fromJson(data);

        // Emit the loaded state with the medication data
        emit(MedicationLoaded(medication));
      } else {
        // Handle the error if status code is not 200
        emit(MedicationError('Failed to load data'));
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      emit(MedicationError('An error occurred: $e'));
    }
  }

  Future<void> reloadData() async {
    print("Medication data reload");
    try {
      // Make the HTTP request
      final response =
          await http.get(Uri.parse('${ApiPath.path}/api/medications'));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Decode the response body as JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Convert the JSON into a MedicationModel
        final medication = MedicationModel.fromJson(data);

        // Emit the loaded state with the medication data
        emit(MedicationLoaded(medication));
      } else {}
    } catch (e) {
      print("Error while laoding the medication data: $e");
    }
  }
}
