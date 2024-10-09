class Transactions {
  int? keyID;
  final String title;
  final String brand;
  final String model;
  final int year;
  final double hp;
  final double torque;
  final DateTime date;

  Transactions({
    this.keyID,
    required this.title,
    required this.brand,
    required this.model,
    required this.year,
    required this.hp,
    required this.torque,
    required this.date,
  });
}