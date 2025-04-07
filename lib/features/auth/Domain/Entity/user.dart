
class UserEntity {
  final String email;
  final String password;

  const UserEntity({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
