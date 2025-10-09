import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/tier.dart';
import '../repositories/membership_repository.dart';

class CreateTier {
  final MembershipRepository repository;

  CreateTier(this.repository);

  Future<Either<Failure, Tier>> call({required String businessId, required Tier tier}) async {
    return repository.createTier(businessId: businessId, tier: tier);
  }
}

class UpdateTier {
  final MembershipRepository repository;

  UpdateTier(this.repository);

  Future<Either<Failure, Tier>> call({required String businessId, required Tier tier}) async {
    return repository.updateTier(businessId: businessId, tier: tier);
  }
}

class DeleteTier {
  final MembershipRepository repository;

  DeleteTier(this.repository);

  Future<Either<Failure, void>> call({required String businessId, required String tierId}) async {
    return repository.deleteTier(businessId: businessId, tierId: tierId);
  }
}
