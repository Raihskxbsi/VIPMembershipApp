import 'package:equatable/equatable.dart';

class Membership extends Equatable {
  final String id;
  final String userId;
  final String businessId;
  final String tierId;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final String status; // e.g. active, expired, cancelled

  const Membership({
    required this.id,
    required this.userId,
    required this.businessId,
    required this.tierId,
    required this.issuedAt,
    this.expiresAt,
    required this.status,
  });

  @override
  List<Object?> get props => [id, userId, businessId, tierId, issuedAt, expiresAt, status];
}
