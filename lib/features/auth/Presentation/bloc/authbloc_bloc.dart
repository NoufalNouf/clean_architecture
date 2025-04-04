import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../Domain/entities/user.dart';

import '../Domain/Repository/auth_repository.dart';
import 'authbloc_event.dart';
import 'authbloc_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(User(email: event.email, password: event.password));
        emit(Authenticated(event.email));
      } catch (e) {
        emit(AuthFailure("Sign up failed"));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signIn(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user.email));
        } else {
          emit(AuthFailure("Invalid credentials"));
        }
      } catch (e) {
        emit(AuthFailure("Sign in failed"));
      }
    });

    on<CheckAuthStatus>((event, emit) async {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await authRepository.signIn('', '');
        emit(Authenticated(user?.email ?? ''));
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      await authRepository.signUp(User(email: '', password: ''));
      emit(Unauthenticated());
    });
  }
}
