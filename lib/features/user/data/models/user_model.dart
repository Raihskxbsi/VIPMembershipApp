import '../../domain/entities/user.dart';
import '../../domain/entities/user_role.dart';
import 'user_role_model.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
    super.phone,
    super.avatarUrl,
    super.roles = const [],
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      roles: _parseRoles(json['roles']),
      createdAt: json['createdAt'] is String
          ? DateTime.parse(json['createdAt'] as String)
          : json['createdAt'] as DateTime,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      displayName: user.displayName,
      phone: user.phone,
      avatarUrl: user.avatarUrl,
      roles: user.roles,
      createdAt: user.createdAt,
    );
  }

  static List<UserRole> _parseRoles(dynamic rolesData) {
    if (rolesData == null) {
      return const [];
    }

    if (rolesData is List) {
      return rolesData
          .map((role) {
            if (role is String) {
              return UserRoleModel.fromString(role);
            }
            return role as UserRole;
          })
          .toList();
    }

    return const [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phone': phone,
      'avatarUrl': avatarUrl,
      'roles': roles.map((r) => r.name).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? phone,
    String? avatarUrl,
    List<UserRole>? roles,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
