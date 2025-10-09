import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/membership.dart';
import '../entities/tier.dart';
import '../entities/redemption.dart';

abstract class MembershipRepository {
  // Tiers
  Future<Either<Failure, List<Tier>>> getTiers({required String businessId});
  Future<Either<Failure, Tier>> createTier({required String businessId, required Tier tier});
  Future<Either<Failure, Tier>> updateTier({required String businessId, required Tier tier});
  Future<Either<Failure, void>> deleteTier({required String businessId, required String tierId});

  // Membership issuance & queries
  Future<Either<Failure, Membership>> issueMembership({
    required String businessId,
    required String userId,
    required String tierId,
  });
  Future<Either<Failure, Membership>> getMembership({required String userId, required String businessId});
  Future<Either<Failure, List<Membership>>> getMembershipsForBusiness({required String businessId});

  // Redemptions (tokens)
  Future<Either<Failure, Redemption>> createRedemptionToken({
    required String userId,
    required String businessId,
    String? perkId,
    required Duration ttl,
  });

  Future<Either<Failure, Redemption>> validateRedemption({required String token});
}
