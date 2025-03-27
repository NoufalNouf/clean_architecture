import 'package:clean_architecture/Presentation/bloc/sign_in_event.dart';
import 'package:clean_architecture/Presentation/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 1)); // Simulate authentication delay
    if (event.username == 'user' && event.password == 'password') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error: 'Invalid username or password'));
    }
  }
}
