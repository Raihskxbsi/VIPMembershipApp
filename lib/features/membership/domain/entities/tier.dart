import 'package:equatable/equatable.dart';

class Tier extends Equatable {
  final String id;
  final String name;
  final String? description;
  final int? durationDays;
  final String? color;
  final Map<String, dynamic>? perks;

  const Tier({
    required this.id,
    required this.name,
    this.description,
    this.durationDays,
    this.color,
    this.perks,
  });

  @override
  List<Object?> get props => [id, name, description, durationDays, color, perks];
}
