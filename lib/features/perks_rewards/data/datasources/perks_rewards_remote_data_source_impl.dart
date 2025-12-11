import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/exclusive_perk_model.dart';
import '../models/reward_model.dart';
import '../models/reward_redemption_model.dart';
import 'perks_rewards_remote_data_source.dart';

class PerksRewardsRemoteDataSourceImpl implements PerksRewardsRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  PerksRewardsRemoteDataSourceImpl({required this.firebaseFirestore});

  static const String _perksCollection = 'exclusive_perks';
  static const String _rewardsCollection = 'rewards';
  static const String _redemptionsCollection = 'reward_redemptions';

  @override
  Future<List<ExclusivePerkModel>> getExclusivePerks() async {
    final querySnapshot = await firebaseFirestore
        .collection(_perksCollection)
        .get();

    return querySnapshot.docs
        .map((doc) => ExclusivePerkModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<List<RewardModel>> getRewards() async {
    final querySnapshot = await firebaseFirestore
        .collection(_rewardsCollection)
        .get();

    return querySnapshot.docs
        .map((doc) => RewardModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<RewardRedemptionModel> redeemReward(String rewardId, String userId) async {
    final redemptionId = const Uuid().v4();
    final now = DateTime.now();

    final redemptionData = {
      'id': redemptionId,
      'userId': userId,
      'rewardId': rewardId,
      'redeemedAt': now.toIso8601String(),
      'status': 'redeemed',
    };

    await firebaseFirestore
        .collection(_redemptionsCollection)
        .doc(redemptionId)
        .set(redemptionData);

    return RewardRedemptionModel.fromJson(redemptionData);
  }

  @override
  Future<ExclusivePerkModel> claimPerk(String perkId, String userId) async {
    final perkDoc = await firebaseFirestore
        .collection(_perksCollection)
        .doc(perkId)
        .get();

    if (!perkDoc.exists) {
      throw Exception('Perk not found');
    }

    final perkData = perkDoc.data() as Map<String, dynamic>;
    
    // Update perk status to claimed
    perkData['status'] = 'claimed';
    
    await firebaseFirestore
        .collection(_perksCollection)
        .doc(perkId)
        .update({'status': 'claimed'});

    return ExclusivePerkModel.fromJson({...perkData, 'id': perkId});
  }
}
