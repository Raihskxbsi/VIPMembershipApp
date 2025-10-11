import 'package:dartz/dartz.dart';
import 'package:grouptask4_mem1/core/errors/failure.dart';
import '../repositories/perks_rewards_repository.dart';
import '../entities/reward_redemption.dart';

class RedeemReward {
  final PerksRewardsRepository repository;

  RedeemReward(this.repository);

  Future<Either<Failure, RewardRedemption>> execute(String userId, String rewardId) {
    return repository.redeemReward(userId, rewardId);
  }
}