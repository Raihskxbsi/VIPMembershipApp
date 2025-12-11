import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/tier_model.dart';
import '../models/membership_model.dart';
import '../models/redemption_model.dart';
import 'membership_remote_data_source.dart';

class MembershipRemoteDataSourceImpl implements MembershipRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  MembershipRemoteDataSourceImpl({required this.firebaseFirestore});

  static const String _tiersCollection = 'tiers';
  static const String _membershipsCollection = 'memberships';
  static const String _redemptionsCollection = 'redemptions';

  @override
  Future<List<TierModel>> getTiers({required String businessId}) async {
    final querySnapshot = await firebaseFirestore
        .collection(_tiersCollection)
        .where('businessId', isEqualTo: businessId)
        .get();

    return querySnapshot.docs
        .map((doc) => TierModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<TierModel> createTier({
    required String businessId,
    required TierModel tier,
  }) async {
    final tierId = const Uuid().v4();
    final tierData = tier.toJson();
    tierData['businessId'] = businessId;
    tierData['id'] = tierId;

    await firebaseFirestore
        .collection(_tiersCollection)
        .doc(tierId)
        .set(tierData);

    return TierModel.fromJson({...tierData, 'id': tierId});
  }

  @override
  Future<TierModel> updateTier({
    required String businessId,
    required TierModel tier,
  }) async {
    final tierData = tier.toJson();
    tierData['businessId'] = businessId;

    await firebaseFirestore
        .collection(_tiersCollection)
        .doc(tier.id)
        .update(tierData);

    return tier;
  }

  @override
  Future<void> deleteTier({
    required String businessId,
    required String tierId,
  }) async {
    await firebaseFirestore
        .collection(_tiersCollection)
        .doc(tierId)
        .delete();
  }

  @override
  Future<MembershipModel> issueMembership({
    required String businessId,
    required String userId,
    required String tierId,
  }) async {
    final membershipId = const Uuid().v4();
    final now = DateTime.now();

    final membershipData = {
      'id': membershipId,
      'userId': userId,
      'businessId': businessId,
      'tierId': tierId,
      'issuedAt': now.toIso8601String(),
      'expiresAt': '',
      'status': 'active',
    };

    await firebaseFirestore
        .collection(_membershipsCollection)
        .doc(membershipId)
        .set(membershipData);

    return MembershipModel.fromJson(membershipData);
  }

  @override
  Future<MembershipModel> getMembership({
    required String userId,
    required String businessId,
  }) async {
    final querySnapshot = await firebaseFirestore
        .collection(_membershipsCollection)
        .where('userId', isEqualTo: userId)
        .where('businessId', isEqualTo: businessId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Membership not found');
    }

    final doc = querySnapshot.docs.first;
    return MembershipModel.fromJson({...doc.data(), 'id': doc.id});
  }

  @override
  Future<List<MembershipModel>> getMembershipsForBusiness({
    required String businessId,
  }) async {
    final querySnapshot = await firebaseFirestore
        .collection(_membershipsCollection)
        .where('businessId', isEqualTo: businessId)
        .get();

    return querySnapshot.docs
        .map((doc) => MembershipModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<RedemptionModel> createRedemptionToken({
    required String userId,
    required String businessId,
    String? perkId,
    required Duration ttl,
  }) async {
    final redemptionId = const Uuid().v4();
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    final redemptionData = {
      'id': redemptionId,
      'userId': userId,
      'businessId': businessId,
      'perkId': perkId,
      'issuedAt': now.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'status': 'issued',
      'redeemedBy': null,
      'redeemedAt': '',
    };

    await firebaseFirestore
        .collection(_redemptionsCollection)
        .doc(redemptionId)
        .set(redemptionData);

    return RedemptionModel.fromJson(redemptionData);
  }

  @override
  Future<RedemptionModel> validateRedemption({
    required String token,
  }) async {
    final querySnapshot = await firebaseFirestore
        .collection(_redemptionsCollection)
        .where('id', isEqualTo: token)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('Redemption token not found');
    }

    final doc = querySnapshot.docs.first;
    final redemptionData = {...doc.data(), 'id': doc.id};
    final redemption = RedemptionModel.fromJson(redemptionData);

    // Check if token is expired
    if (redemption.expiresAt.isBefore(DateTime.now())) {
      throw Exception('Redemption token has expired');
    }

    // Check if already redeemed
    if (redemption.status != 'issued') {
      throw Exception('Redemption token has already been redeemed');
    }

    return redemption;
  }
}
