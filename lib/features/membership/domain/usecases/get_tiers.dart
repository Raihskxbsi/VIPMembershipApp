import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/tier.dart';
import '../repositories/membership_repository.dart';

class GetTiers {
  final MembershipRepository repository;

  GetTiers(this.repository);

  Future<Either<Failure, List<Tier>>> call({required String businessId}) async {
    return repository.getTiers(businessId: businessId);
  }
}
