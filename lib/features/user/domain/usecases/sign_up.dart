import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignUp {
  final UserRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return repository.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
