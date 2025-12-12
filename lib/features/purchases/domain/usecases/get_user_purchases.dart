import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/purchases_repository.dart';
import '../entities/purchase.dart';

class GetUserPurchases {
  final PurchasesRepository repository;

  GetUserPurchases(this.repository);

  Future<Either<Failure, List<Purchase>>> execute({required String userId}) {
    return repository.getUserPurchases(userId: userId);
  }
}
