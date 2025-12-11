import '../../domain/entities/user_role.dart';

/// Utility class for UserRole model conversions and serialization
class UserRoleModel {
  static UserRole fromString(String roleString) {
    return switch (roleString.toLowerCase()) {
      'admin' => UserRole.admin,
      'customer' => UserRole.customer,
      _ => UserRole.customer,
    };
  }

  static String roleToString(UserRole role) {
    return role.name;
  }
}
