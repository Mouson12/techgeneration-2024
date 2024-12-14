class SensorModel {
  final double min;
  final double max;
  final double value;

  SensorModel({
    required this.min,
    required this.max,
    required this.value,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      min: json['min']?.toDouble() ?? 0.0,
      max: json['max']?.toDouble() ?? 0.0,
      value: json['value']?.toDouble() ??
          0.0, // Default to 0 if value is not present
    );
  }
}
