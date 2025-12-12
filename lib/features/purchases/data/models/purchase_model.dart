import '../../domain/entities/purchase.dart';

class PurchaseModel extends Purchase {
  const PurchaseModel({
    required super.id,
    required super.userId,
    required super.productId,
    required super.purchasedAt,
    required super.amount,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      purchasedAt:
          json['purchasedAt'] != null &&
              (json['purchasedAt'] as String).isNotEmpty
          ? DateTime.parse(json['purchasedAt'] as String)
          : DateTime.now(),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'purchasedAt': purchasedAt.toIso8601String(),
      'amount': amount,
    };
  }
}
