import 'package:equatable/equatable.dart';

class Redemption extends Equatable {
  final String id;
  final String userId;
  final String businessId;
  final String? perkId;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final String status; // issued, redeemed, cancelled
  final String? redeemedBy;
  final DateTime? redeemedAt;

  const Redemption({
    required this.id,
    required this.userId,
    required this.businessId,
    this.perkId,
    required this.issuedAt,
    required this.expiresAt,
    required this.status,
    this.redeemedBy,
    this.redeemedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        businessId,
        perkId,
        issuedAt,
        expiresAt,
        status,
        redeemedBy,
        redeemedAt,
      ];
}
