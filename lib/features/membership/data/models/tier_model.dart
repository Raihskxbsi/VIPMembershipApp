import '../../domain/entities/tier.dart';

class TierModel extends Tier {
  const TierModel({
    required super.id,
    required super.name,
    super.description,
    super.durationDays,
    super.color,
    super.perks,
  });

  factory TierModel.fromJson(Map<String, dynamic> json) {
    return TierModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      durationDays: json['durationDays'] as int?,
      color: json['color'] as String?,
      perks: json['perks'] as Map<String, dynamic>?,
    );
  }

  factory TierModel.fromEntity(Tier tier) {
    return TierModel(
      id: tier.id,
      name: tier.name,
      description: tier.description,
      durationDays: tier.durationDays,
      color: tier.color,
      perks: tier.perks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'durationDays': durationDays,
      'color': color,
      'perks': perks,
    };
  }
}
