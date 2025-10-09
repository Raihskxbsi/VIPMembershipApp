import 'package:equatable/equatable.dart';
import 'user_role.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? phone;
  final String? avatarUrl;
  final List<UserRole> roles;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    this.displayName,
    this.phone,
    this.avatarUrl,
    this.roles = const [UserRole.customer],
    required this.createdAt,
  });

  bool get isAdmin => roles.contains(UserRole.admin);

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? phone,
    String? avatarUrl,
    List<UserRole>? roles,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, email, displayName, phone, avatarUrl, roles, createdAt];
}
