import 'package:dartz/dartz.dart';
import '../entities/exclusive_perk.dart';
import '../entities/reward.dart';
import '../entities/reward_redemption.dart';

abstract class PerksRewardsRepository {
  Future<Either<Failure, List<ExclusivePerk>>> getExclusivePerks();
  Future<Either<Failure, List<Reward>>> getRewards();
  Future<Either<Failure, RewardRedemption>> redeemReward(String rewardId, String userId);
  Future<Either<Failure, ExclusivePerk>> claimPerk(String perkId, String userId);
}