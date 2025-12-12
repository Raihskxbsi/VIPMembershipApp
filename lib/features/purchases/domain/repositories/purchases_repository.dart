import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product.dart';
import '../entities/purchase.dart';

abstract class PurchasesRepository {
  Future<Either<Failure, List<Product>>> getProducts({
    required String businessId,
  });
  Future<Either<Failure, Purchase>> purchaseProduct({
    required String userId,
    required String businessId,
    required String productId,
  });
  Future<Either<Failure, List<Purchase>>> getUserPurchases({
    required String userId,
  });
}
