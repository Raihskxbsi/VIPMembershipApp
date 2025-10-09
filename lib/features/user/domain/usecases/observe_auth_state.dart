// No dartz needed here; this use case exposes a Stream<User?>
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ObserveAuthState {
  final UserRepository repository;
  ObserveAuthState(this.repository);

  Stream<User?> call() {
    return repository.observeAuthState();
  }
}
