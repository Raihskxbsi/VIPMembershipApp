import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/purchases_repository.dart';
import '../entities/purchase.dart';

class PurchaseProduct {
  final PurchasesRepository repository;

  PurchaseProduct(this.repository);

  Future<Either<Failure, Purchase>> execute({
    required String userId,
    required String businessId,
    required String productId,
  }) {
    return repository.purchaseProduct(
      userId: userId,
      businessId: businessId,
      productId: productId,
    );
  }
}
