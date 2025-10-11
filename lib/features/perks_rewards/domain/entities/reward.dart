class Reward extends Equatable {
  final String id;
  final String title;
  final String details;
  final int pointsRequired;
  final DateTime expirationDate;

  const Reward({
    required this.id,
    required this.title,
    required this.details,
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