import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/redemption.dart';
import '../repositories/membership_repository.dart';

class CreateRedemptionToken {
  final MembershipRepository repository;

  CreateRedemptionToken(this.repository);

  Future<Either<Failure, Redemption>> call({
    required String userId,
    required String businessId,
    String? perkId,
    required Duration ttl,
  }) async {
    return repository.createRedemptionToken(
        userId: userId, businessId: businessId, perkId: perkId, ttl: ttl);
  }
}

class ValidateRedemption {
  final MembershipRepository repository;

  ValidateRedemption(this.repository);

  Future<Either<Failure, Redemption>> call({required String token}) async {
    return repository.validateRedemption(token: token);
  }
}
