import 'package:dartz/dartz.dart';
import 'package:grouptask4_mem1/core/errors/failure.dart';
import 'package:grouptask4_mem1/features/perks_rewards/domain/entities/exclusive_perk.dart';
import '../repositories/perks_rewards_repository.dart';

class ClaimPerk {
  final PerksRewardsRepository repository;

  ClaimPerk(this.repository);

  Future<Either<Failure, ExclusivePerk>> execute(String perkId, String userId) {
    return repository.claimPerk(perkId, userId);
  }
}

class SuccessType {
  final String message;

  SuccessType(this.message);
}