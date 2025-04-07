import 'dart:async';

import 'package:clean_architecture/features/auth/Domain/Repository/auth_repository.dart';

class CheckEmailUsecase{
  final AuthRepository repository;

  CheckEmailUsecase(this.repository);

  Future<String?> call(String email) async{
    try{
      final res =  await repository.getEmail();
      if (res == email) {
        return Future.value("Email Already Exists");
      }
      return null;
    }catch(e)
    {
      print("ERROR");
    }
    return null;
  }


}