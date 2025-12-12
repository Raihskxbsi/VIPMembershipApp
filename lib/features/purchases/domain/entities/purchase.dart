class Purchase {
  final String id;
  final String userId;
  final String productId;
  final DateTime purchasedAt;
  final double amount;

  const Purchase({
    required this.id,
    required this.userId,
    required this.productId,
    required this.purchasedAt,
    required this.amount,
  });
}
