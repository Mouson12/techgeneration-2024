class AlertModel {
  bool isDanger;

  AlertModel({required this.isDanger});

  factory AlertModel.fromJson(Map<String, dynamic> json) {
    // Check if "fall_detected" exists and is true
    bool danger = json['fall_detected'] == true;

    return AlertModel(isDanger: danger);
  }
}
