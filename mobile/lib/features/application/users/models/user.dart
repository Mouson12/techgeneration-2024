class User {
  final String name;
  final int points;

  User({
    required this.name,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['user'],
      points: json['score'],
    );
  }
}
