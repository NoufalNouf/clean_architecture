
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/auth/Data/repository/auth_repository_impl.dart';
import 'features/auth/Domain/UseCases/is_loggedin_usecase.dart';
import 'features/auth/Domain/UseCases/signin_usecase.dart';
import 'features/auth/Domain/UseCases/signout_usecase.dart';
import 'features/auth/Domain/UseCases/signup_usecase.dart';
import 'features/auth/Presentation/bloc/authbloc_bloc.dart';
import 'features/auth/Presentation/pages/home_page.dart';
import 'features/auth/Presentation/pages/signin_page.dart';
import 'features/auth/Presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter;
  await Hive.openBox('authBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => SignInPage()),
      GoRoute(path: "/signup", builder: (context, state) => SignUpPage()),
      GoRoute(path: "/home", builder: (context, state) => HomePage()),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AuthBloc(
            signUpUseCase: SignUpUseCase(
                AuthRepositoryImpl(),
            ),
            signInUseCase: SignInUseCase(
              AuthRepositoryImpl(),
            ),
            isLoggedInUseCase: IsLoggedInUseCase(
              AuthRepositoryImpl(),
            ),
            signOutUseCase: SignOutUseCase(
              AuthRepositoryImpl(),
            ),
          ),

lazy: false,
      child:  MaterialApp.router(
        title: "Auth App",
        routerConfig: _router,
        theme: ThemeData(primarySwatch: Colors.blue),
      )

    );
  }
}

