import 'package:equatable/equatable.dart';

/// Base Failure class for domain errors.
/// Extend this for concrete failures (e.g. AuthenticationFailure, NetworkFailure).
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType: $message';
}
