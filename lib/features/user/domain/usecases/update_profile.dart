import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class UpdateProfile {
  final UserRepository repository;
  UpdateProfile(this.repository);

  Future<Either<Failure, User>> call({
    required String userId,
    String? displayName,
    String? phone,
    String? avatarUrl,
  }) async {
    return repository.updateProfile(
      userId: userId,
      displayName: displayName,
      phone: phone,
      avatarUrl: avatarUrl,
    );
  }
}
