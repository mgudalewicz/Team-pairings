import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parowanie/app/features/auth/login/cubit/login_cubit.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final email = TextEditingController();
final password = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.isCreatingAccount
                        ? 'Zarejestruj się'
                        : 'Zaloguj się'),
                    const SizedBox(height: 20),
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                    ),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Hasło'),
                    ),
                    const SizedBox(height: 20),
                    Text(state.errorMessage),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (state.isCreatingAccount) {
                          // rejestracja
                          try {
                            context
                                .read<LoginCubit>()
                                .signUp(email.text, password.text);
                          } catch (error) {
                            Center(
                              child: Text(
                                'Something went wrong : ${state.errorMessage}',
                              ),
                            );
                          }
                        } else {
                          // logowanie
                          try {
                            context
                                .read<LoginCubit>()
                                .signIn(email.text, password.text);
                          } catch (error) {
                            Center(
                              child: Text(
                                'Something went wrong : ${state.errorMessage}',
                              ),
                            );
                          }
                        }
                      },
                      child: Text(state.isCreatingAccount
                          ? 'Zarejestruj się'
                          : 'Zaloguj się'),
                    ),
                    const SizedBox(height: 20),
                    if (state.isCreatingAccount == false) ...{
                      TextButton(
                        onPressed: () {
                          context.read<LoginCubit>().setState();
                        },
                        child: const Text("Utwórz konto"),
                      ),
                    },
                    if (state.isCreatingAccount == true) ...{
                      TextButton(
                        onPressed: () {
                          context.read<LoginCubit>().start();
                        },
                        child: const Text("Masz już konto?"),
                      )
                    }
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}