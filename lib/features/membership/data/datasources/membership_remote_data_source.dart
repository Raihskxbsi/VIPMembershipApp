import '../models/tier_model.dart';
import '../models/membership_model.dart';
import '../models/redemption_model.dart';

abstract class MembershipRemoteDataSource {
  // Tiers
  Future<List<TierModel>> getTiers({required String businessId});
  Future<TierModel> createTier({required String businessId, required TierModel tier});
  Future<TierModel> updateTier({required String businessId, required TierModel tier});
  Future<void> deleteTier({required String businessId, required String tierId});

  // Membership issuance & queries
  Future<MembershipModel> issueMembership({
    required String businessId,
    required String userId,
    required String tierId,
  });
  Future<MembershipModel> getMembership({required String userId, required String businessId});
  Future<List<MembershipModel>> getMembershipsForBusiness({required String businessId});

  // Redemptions (tokens)
  Future<RedemptionModel> createRedemptionToken({
    required String userId,
    required String businessId,
    String? perkId,
    required Duration ttl,
  });

  Future<RedemptionModel> validateRedemption({required String token});
}
