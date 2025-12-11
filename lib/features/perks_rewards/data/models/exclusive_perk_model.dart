import '../../domain/entities/exclusive_perk.dart';

class ExclusivePerkModel extends ExclusivePerk {
  const ExclusivePerkModel({
    required super.id,
    required super.name,
    required super.description,
    required super.validity,
    required super.status,
  });

  factory ExclusivePerkModel.fromJson(Map<String, dynamic> json) {
    return ExclusivePerkModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      validity: DateTime.parse(json['validity'] as String),
      status: json['status'] as String,
    );
  }

  factory ExclusivePerkModel.fromEntity(ExclusivePerk perk) {
    return ExclusivePerkModel(
      id: perk.id,
      name: perk.name,
      description: perk.description,
      validity: perk.validity,
      status: perk.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'validity': validity.toIso8601String(),
      'status': status,
    };
  }
}
