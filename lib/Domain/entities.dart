import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;

  const User({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

class ValidateUser {
  Future<bool> call(String username, String password) async {
    // Simulate a delay as if validating credentials
    await Future.delayed(Duration(seconds: 1));
    return username == 'user' && password == 'password';
  }
}
