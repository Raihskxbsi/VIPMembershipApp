import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/entities/exclusive_perk.dart';
import '../../domain/entities/reward.dart';
import '../../domain/entities/reward_redemption.dart';
import '../../domain/repositories/perks_rewards_repository.dart';
import '../datasources/perks_rewards_remote_data_source.dart';

class PerksRewardsRepositoryImpl implements PerksRewardsRepository {
  final PerksRewardsRemoteDataSource remoteDataSource;

  PerksRewardsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ExclusivePerk>>> getExclusivePerks() async {
    try {
      final perks = await remoteDataSource.getExclusivePerks();
      return Right(perks);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch exclusive perks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Reward>>> getRewards() async {
    try {
      final rewards = await remoteDataSource.getRewards();
      return Right(rewards);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch rewards: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, RewardRedemption>> redeemReward(String rewardId, String userId) async {
    try {
      final redemption = await remoteDataSource.redeemReward(rewardId, userId);
      return Right(redemption);
    } catch (e) {
      return Left(ServerFailure('Failed to redeem reward: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ExclusivePerk>> claimPerk(String perkId, String userId) async {
    try {
      final claimedPerk = await remoteDataSource.claimPerk(perkId, userId);
      return Right(claimedPerk);
    } catch (e) {
      return Left(ServerFailure('Failed to claim perk: ${e.toString()}'));
    }
  }
}
