import '../Repository/auth_repository.dart';
import '../entities/user.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
