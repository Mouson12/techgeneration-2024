import 'package:intl/intl.dart';

class MedicationModel {
  DateTime lastDose;
  DateTime nextDose;
  double delayMinutes;

  MedicationModel({
    required this.lastDose,
    required this.nextDose,
    required this.delayMinutes,
  });

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    final DateFormat dateFormat = DateFormat(
        'EEE, dd MMM yyyy HH:mm:ss z'); // Format matching the input string

    return MedicationModel(
      lastDose: dateFormat.parse(json['last_dose']),
      nextDose: dateFormat.parse(json['next_dose']),
      delayMinutes: json['delay_minutes'].toDouble(),
    );
  }
}
