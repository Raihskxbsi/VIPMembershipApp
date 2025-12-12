import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/purchases_repository.dart';
import '../entities/product.dart';

class GetProducts {
  final PurchasesRepository repository;

  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> execute({required String businessId}) {
    return repository.getProducts(businessId: businessId);
  }
}
