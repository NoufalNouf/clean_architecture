import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sign_in_bloc.dart';
import '../bloc/sign_in_event.dart';
import '../bloc/sign_in_state.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username',border: OutlineInputBorder()),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password',border: OutlineInputBorder()),
            obscureText: true,
          ),
          SizedBox(height: 10),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is LoginSuccess) {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(
                    LoginButtonPressed(
                      username: _usernameController.text,
                      password: _passwordController.text,
                    ),
                  );
                },
                child: Text('Login'),
              );
            },
          ),
        ],
      ),
    );
  }
}


