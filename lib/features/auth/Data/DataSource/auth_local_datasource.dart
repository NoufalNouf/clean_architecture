import 'package:hive/hive.dart';

class AuthLocalDataSource {
  final Box userBox = Hive.box('userBox');

  Future<void> saveCredentials(String email, String password) async {
    await userBox.put('email', email);
    await userBox.put('password', password);
  }

  Future<Map<String, String>?> getCredentials() async {
    final email = userBox.get('email');
    final password = userBox.get('password');
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    } else {
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final email = userBox.get('email');
    final password = userBox.get('password');
    return email != null && password != null;
  }

  Future<void> clearCredentials() async {
    await userBox.clear();
  }
}
