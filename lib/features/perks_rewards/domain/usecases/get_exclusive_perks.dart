import 'package:dartz/dartz.dart';
import 'package:grouptask4_mem1/core/errors/failure.dart';
import '../repositories/perks_rewards_repository.dart';
import '../entities/exclusive_perk.dart';

class GetExclusivePerks {
  final PerksRewardsRepository repository;

  GetExclusivePerks(this.repository);

  Future<Either<Failure, List<ExclusivePerk>>> execute() {
    return repository.getExclusivePerks();
  }
}