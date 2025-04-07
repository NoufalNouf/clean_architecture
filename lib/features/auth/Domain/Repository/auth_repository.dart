
import '../Entity/user.dart';

abstract class AuthRepository {
  Future<void> signUp(UserEntity user);
  Future<UserEntity?> signIn(String email, String password);
  Future<bool> isLoggedIn();
  Future<void> signOut();
  Future<String?> getEmail();
}
