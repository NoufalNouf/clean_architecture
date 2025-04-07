
import '../../Data/repository/auth_repository_impl.dart';
import '../Repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepositoryImpl repository;

  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}
