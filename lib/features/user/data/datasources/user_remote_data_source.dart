import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Sign up a user using Firebase Auth (email & password). Returns the created UserModel on success.
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in a user with email & password.
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign out current user.
  Future<void> signOut();

  /// Get currently signed-in user, or null if none.
  Future<UserModel?> getCurrentUser();

  /// Update the user's profile fields (non-null fields will be updated).
  Future<UserModel> updateProfile({
    required String userId,
    String? displayName,
    String? phone,
    String? avatarUrl,
  });

  /// Observe authentication state changes as a stream of UserModel? events.
  Stream<UserModel?> observeAuthState();
}
