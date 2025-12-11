import '../models/exclusive_perk_model.dart';
import '../models/reward_model.dart';
import '../models/reward_redemption_model.dart';

abstract class PerksRewardsRemoteDataSource {
  Future<List<ExclusivePerkModel>> getExclusivePerks();
  Future<List<RewardModel>> getRewards();
  Future<RewardRedemptionModel> redeemReward(String rewardId, String userId);
  Future<ExclusivePerkModel> claimPerk(String perkId, String userId);
}
