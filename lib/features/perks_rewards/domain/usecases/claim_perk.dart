import 'package:dartz/dartz.dart';
import '../repositories/perks_rewards_repository.dart';

class ClaimPerk {
  final PerksRewardsRepository repository;

  ClaimPerk(this.repository);

  Future<Either<Failure, SuccessType>> execute(String perkId, String userId) {
    return repository.claimPerk(perkId, userId);
  }
}