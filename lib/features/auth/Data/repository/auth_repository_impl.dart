import 'package:hive/hive.dart';
import '../../Domain/Entity/user.dart';
import '../../Domain/Repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Box _authBox = Hive.box('authBox');

  @override
  Future<bool> isLoggedIn() async {
    return _authBox.containsKey('email') && _authBox.containsKey('password');
  }

  @override
  Future<void> signOut() async {
    await _authBox.delete('email');
    await _authBox.delete('password');
  }

  @override
  Future<void> signUp(UserEntity user)async {
       await _authBox.put('email', user.email);
       await _authBox.put('password', user.password);

  }

  @override
  Future<UserEntity?> signIn(String email, String password) {
    final storedEmail = _authBox.get('email') as String?;
    final storedPassword = _authBox.get('password') as String?;

    if (storedEmail != null && storedPassword != null && storedEmail == email && storedPassword == password) {
      return Future.value(UserEntity(email: email, password: password));
    }
    return Future.value(null);
  }

  @override
  Future<String?> getEmail() {
    throw UnimplementedError();
  }


}
