import '../../domain/entities/reward.dart';

class RewardModel extends Reward {
  const RewardModel({
    required super.id,
    required super.title,
    required super.details,
    required super.pointsRequired,
    required super.expirationDate,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      details: json['details'] as String,
      pointsRequired: json['pointsRequired'] as int,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );
  }

  factory RewardModel.fromEntity(Reward reward) {
    return RewardModel(
      id: reward.id,
      title: reward.title,
      details: reward.details,
      pointsRequired: reward.pointsRequired,
      expirationDate: reward.expirationDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'pointsRequired': pointsRequired,
      'expirationDate': expirationDate.toIso8601String(),
    };
  }
}
