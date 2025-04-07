import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/Entity/user.dart';
import '../../Domain/UseCases/is_loggedin_usecase.dart';
import '../../Domain/UseCases/signin_usecase.dart';
import '../../Domain/UseCases/signout_usecase.dart';
import '../../Domain/UseCases/signup_usecase.dart';
import 'authbloc_event.dart';
import 'authbloc_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.isLoggedInUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await signUpUseCase(
          UserEntity(email: event.email, password: event.password),
        );
        emit(Authenticated(event.email));
      } catch (e) {
        emit(AuthFailure("Sign up failed"));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await signInUseCase(event.email, event.password);
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
      final isLoggedIn = await isLoggedInUseCase();
      if (isLoggedIn) {
        emit(Authenticated("User is logged in"));
      } else {
        emit(Unauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      await signOutUseCase();
      emit(Unauthenticated());
    });


   on<UserEmailTyped>(userEmailTyped);
  }
  FutureOr<void> userEmailTyped(UserEmailTyped event, Emitter<AuthState> emit) {
    
  }
}
