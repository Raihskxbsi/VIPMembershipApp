enum UserRole {
  customer,
  admin,
}

extension UserRoleX on UserRole {
  String get name => toString().split('.').last;
}
