import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  UserRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  static const String _usersCollection = 'users';

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    // Create user in Firebase Auth
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) {
      throw Exception('Failed to create user account');
    }

    // Update display name if provided
    if (displayName != null && displayName.isNotEmpty) {
      await user.updateDisplayName(displayName);
    }

    // Create user document in Firestore
    final userModel = UserModel(
      id: user.uid,
      email: user.email ?? email,
      displayName: displayName ?? user.displayName,
      phone: user.phoneNumber,
      avatarUrl: user.photoURL,
      roles: const [],
      createdAt: DateTime.now(),
    );

    await firebaseFirestore
        .collection(_usersCollection)
        .doc(user.uid)
        .set(userModel.toJson());

    return userModel;
  }

  @override
  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;
    if (user == null) {
      throw Exception('Failed to sign in user');
    }

    // Retrieve user document from Firestore
    final docSnapshot = await firebaseFirestore
        .collection(_usersCollection)
        .doc(user.uid)
        .get();

    if (docSnapshot.exists) {
      return UserModel.fromJson({
        ...docSnapshot.data() ?? {},
        'id': user.uid,
      });
    }

    // Fallback: create user model from auth user
    return UserModel(
      id: user.uid,
      email: user.email ?? email,
      displayName: user.displayName,
      phone: user.phoneNumber,
      avatarUrl: user.photoURL,
      roles: const [],
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return null;
    }

    try {
      final docSnapshot = await firebaseFirestore
          .collection(_usersCollection)
          .doc(firebaseUser.uid)
          .get();

      if (docSnapshot.exists) {
        return UserModel.fromJson({
          ...docSnapshot.data() ?? {},
          'id': firebaseUser.uid,
        });
      }

      // Fallback: create user model from auth user
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        phone: firebaseUser.phoneNumber,
        avatarUrl: firebaseUser.photoURL,
        roles: const [],
        createdAt: DateTime.now(),
      );
    } catch (e) {
      // If Firestore fetch fails, return basic model from auth user
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        phone: firebaseUser.phoneNumber,
        avatarUrl: firebaseUser.photoURL,
        roles: const [],
        createdAt: DateTime.now(),
      );
    }
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? displayName,
    String? phone,
    String? avatarUrl,
  }) async {
    // Update Firebase Auth user if displayName or avatarUrl provided
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null && firebaseUser.uid == userId) {
      if (displayName != null && displayName.isNotEmpty) {
        await firebaseUser.updateDisplayName(displayName);
      }
      if (avatarUrl != null && avatarUrl.isNotEmpty) {
        await firebaseUser.updatePhotoURL(avatarUrl);
      }
    }

    // Get current user document from Firestore
    final docSnapshot = await firebaseFirestore
        .collection(_usersCollection)
        .doc(userId)
        .get();

    if (!docSnapshot.exists) {
      throw Exception('User not found');
    }

    final currentData = docSnapshot.data() ?? {};
    final updateData = <String, dynamic>{};

    if (displayName != null) {
      updateData['displayName'] = displayName;
    }
    if (phone != null) {
      updateData['phone'] = phone;
    }
    if (avatarUrl != null) {
      updateData['avatarUrl'] = avatarUrl;
    }

    if (updateData.isNotEmpty) {
      await firebaseFirestore
          .collection(_usersCollection)
          .doc(userId)
          .update(updateData);
    }

    // Return updated user model
    final updatedData = {...currentData, ...updateData};
    return UserModel.fromJson({
      ...updatedData,
      'id': userId,
    });
  }

  @override
  Stream<UserModel?> observeAuthState() {
    return firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }

      try {
        final docSnapshot = await firebaseFirestore
            .collection(_usersCollection)
            .doc(firebaseUser.uid)
            .get();

        if (docSnapshot.exists) {
          return UserModel.fromJson({
            ...docSnapshot.data() ?? {},
            'id': firebaseUser.uid,
          });
        }

        // Fallback: create user model from auth user
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName,
          phone: firebaseUser.phoneNumber,
          avatarUrl: firebaseUser.photoURL,
          roles: const [],
          createdAt: DateTime.now(),
        );
      } catch (e) {
        // If Firestore fetch fails, return basic model from auth user
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName,
          phone: firebaseUser.phoneNumber,
          avatarUrl: firebaseUser.photoURL,
          roles: const [],
          createdAt: DateTime.now(),
        );
      }
    });
  }
}
