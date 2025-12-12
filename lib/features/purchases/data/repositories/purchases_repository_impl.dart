import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/purchase.dart';
import '../../domain/repositories/purchases_repository.dart';
import '../datasources/purchases_remote_data_source.dart';
// ...existing imports...

class PurchasesRepositoryImpl implements PurchasesRepository {
  final PurchasesRemoteDataSource remoteDataSource;

  PurchasesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    required String businessId,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        businessId: businessId,
      );
      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch products: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Purchase>> purchaseProduct({
    required String userId,
    required String businessId,
    required String productId,
  }) async {
    try {
      final purchase = await remoteDataSource.createPurchase(
        userId: userId,
        businessId: businessId,
        productId: productId,
      );
      return Right(purchase);
    } catch (e) {
      return Left(ServerFailure('Failed to create purchase: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Purchase>>> getUserPurchases({
    required String userId,
  }) async {
    try {
      final purchases = await remoteDataSource.getUserPurchases(userId: userId);
      return Right(purchases);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch purchases: ${e.toString()}'));
    }
  }
}
