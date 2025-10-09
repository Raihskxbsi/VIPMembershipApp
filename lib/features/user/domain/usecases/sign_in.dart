import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignIn {
  final UserRepository repository;

  SignIn(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return repository.signInWithEmail(email: email, password: password);
  }
}
