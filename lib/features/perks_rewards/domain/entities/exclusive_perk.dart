import 'package:equatable/equatable.dart';

class ExclusivePerk extends Equatable {
  final String id;
  final String name;
  final String description;
  final DateTime validity;
  final String status; // active, inactive, claimed

  const ExclusivePerk({
    required this.id,
    required this.name,
    required this.description,
    required this.validity,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        validity,
        status,
      ];
}