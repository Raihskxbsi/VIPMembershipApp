import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final String id;
  final String title;
  final String details;
  final int pointsRequired;
  final DateTime expirationDate;

  const Reward({
    required this.id, //id of the reward
    required this.title, //title of the reward
    required this.details, //details of the reward
    required this.pointsRequired,
    required this.expirationDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        details,
        pointsRequired,
        expirationDate,
      ];
}