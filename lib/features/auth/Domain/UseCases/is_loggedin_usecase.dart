import 'package:clean_architecture/features/auth/Data/repository/auth_repository_impl.dart';

import '../Repository/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}
