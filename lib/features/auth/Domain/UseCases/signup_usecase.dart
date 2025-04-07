import '../../Data/repository/auth_repository_impl.dart';
import '../Entity/user.dart';
import '../Repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepositoryImpl repository;

  SignUpUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return await repository.signUp(user);
  }
}
