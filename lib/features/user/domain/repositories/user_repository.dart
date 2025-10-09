import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  /// Sign up a user using Firebase Auth (email & password). Returns the created User on success.
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in a user with email & password.
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign out current user.
  Future<Either<Failure, void>> signOut();

  /// Get currently signed-in user, or null if none.
  Future<Either<Failure, User?>> getCurrentUser();

  /// Update the user's profile fields (non-null fields will be updated).
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? displayName,
    String? phone,
    String? avatarUrl,
  });

  /// Observe authentication state changes as a stream of User? events.
  Stream<User?> observeAuthState();
}
