import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/server_failure.dart';
import '../../domain/entities/membership.dart';
import '../../domain/entities/tier.dart';
import '../../domain/entities/redemption.dart';
import '../../domain/repositories/membership_repository.dart';
import '../datasources/membership_remote_data_source.dart';
import '../models/tier_model.dart';
import '../models/membership_model.dart';
import '../models/redemption_model.dart';

class MembershipRepositoryImpl implements MembershipRepository {
  final MembershipRemoteDataSource remoteDataSource;

  MembershipRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Tier>>> getTiers({required String businessId}) async {
    try {
      final tiers = await remoteDataSource.getTiers(businessId: businessId);
      return Right(tiers);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch tiers: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Tier>> createTier({
    required String businessId,
    required Tier tier,
  }) async {
    try {
      final tierModel = TierModel.fromEntity(tier);
      final createdTier = await remoteDataSource.createTier(
        businessId: businessId,
        tier: tierModel,
      );
      return Right(createdTier);
    } catch (e) {
      return Left(ServerFailure('Failed to create tier: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Tier>> updateTier({
    required String businessId,
    required Tier tier,
  }) async {
    try {
      final tierModel = TierModel.fromEntity(tier);
      final updatedTier = await remoteDataSource.updateTier(
        businessId: businessId,
        tier: tierModel,
      );
      return Right(updatedTier);
    } catch (e) {
      return Left(ServerFailure('Failed to update tier: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTier({
    required String businessId,
    required String tierId,
  }) async {
    try {
      await remoteDataSource.deleteTier(
        businessId: businessId,
        tierId: tierId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to delete tier: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Membership>> issueMembership({
    required String businessId,
    required String userId,
    required String tierId,
  }) async {
    try {
      final membership = await remoteDataSource.issueMembership(
        businessId: businessId,
        userId: userId,
        tierId: tierId,
      );
      return Right(membership);
    } catch (e) {
      return Left(ServerFailure('Failed to issue membership: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Membership>> getMembership({
    required String userId,
    required String businessId,
  }) async {
    try {
      final membership = await remoteDataSource.getMembership(
        userId: userId,
        businessId: businessId,
      );
      return Right(membership);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch membership: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Membership>>> getMembershipsForBusiness({
    required String businessId,
  }) async {
    try {
      final memberships = await remoteDataSource.getMembershipsForBusiness(
        businessId: businessId,
      );
      return Right(memberships);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch memberships: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Redemption>> createRedemptionToken({
    required String userId,
    required String businessId,
    String? perkId,
    required Duration ttl,
  }) async {
    try {
      final redemption = await remoteDataSource.createRedemptionToken(
        userId: userId,
        businessId: businessId,
        perkId: perkId,
        ttl: ttl,
      );
      return Right(redemption);
    } catch (e) {
      return Left(ServerFailure('Failed to create redemption token: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Redemption>> validateRedemption({
    required String token,
  }) async {
    try {
      final redemption = await remoteDataSource.validateRedemption(token: token);
      return Right(redemption);
    } catch (e) {
      return Left(ServerFailure('Failed to validate redemption: ${e.toString()}'));
    }
  }
}
