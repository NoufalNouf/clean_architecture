import '../../Data/repository/auth_repository_impl.dart' show AuthRepositoryImpl;
import '../Entity/user.dart';

class SignInUseCase {
  final AuthRepositoryImpl repository;

  SignInUseCase(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
