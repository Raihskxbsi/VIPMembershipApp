import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/membership.dart';
import '../repositories/membership_repository.dart';

class IssueMembership {
  final MembershipRepository repository;

  IssueMembership(this.repository);

  Future<Either<Failure, Membership>> call({
    required String businessId,
    required String userId,
    required String tierId,
  }) async {
    return repository.issueMembership(businessId: businessId, userId: userId, tierId: tierId);
  }
}

class GetMembership {
  final MembershipRepository repository;

  GetMembership(this.repository);

  Future<Either<Failure, Membership>> call({required String userId, required String businessId}) async {
    return repository.getMembership(userId: userId, businessId: businessId);
  }
}

class GetMembershipsForBusiness {
  final MembershipRepository repository;

  GetMembershipsForBusiness(this.repository);

  Future<Either<Failure, List<Membership>>> call({required String businessId}) async {
    return repository.getMembershipsForBusiness(businessId: businessId);
  }
}
