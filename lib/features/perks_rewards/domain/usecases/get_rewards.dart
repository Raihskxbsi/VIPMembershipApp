import 'package:dartz/dartz.dart';
import 'package:grouptask4_mem1/core/errors/failure.dart';
import '../repositories/perks_rewards_repository.dart';
import '../entities/reward.dart';

class GetRewards {
  final PerksRewardsRepository repository;

  GetRewards(this.repository);

  Future<Either<Failure, List<Reward>>> execute() {
    return repository.getRewards();
  }
}