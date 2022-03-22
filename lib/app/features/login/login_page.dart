import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

var errorMessage = '';
var isCreatingAccount = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(isCreatingAccount == true ? 'Rejestracja' : 'Logowanie')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'Podaj swój e-mail',
                ),
                controller: widget.emailController,
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Hasło',
                  hintText: 'Podaj swoje hasło',
                ),
                controller: widget.passwordController,
              ),
              const SizedBox(height: 20),
              Text(errorMessage, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (isCreatingAccount == true) {
                      //rejestracja
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                        );
                      } catch (error) {
                        setState(() {
                          if (error.toString() ==
                              '[firebase_auth/unknown] Given String is empty or null') {
                            errorMessage = 'Musisz uzupełnić pola';
                          } else if (error.toString() ==
                              '[firebase_auth/invalid-email] The email address is badly formatted.') {
                            errorMessage = 'Tak nie wygląda adres e-mail';
                          } else if (error.toString() ==
                              '[firebase_auth/weak-password] Password should be at least 6 characters') {
                            errorMessage =
                                'Hasło musi składać się przynajmniej z 6 znaków';
                          } else {
                            errorMessage = error.toString();
                          }
                        });
                      }
                    } else if (isCreatingAccount == false) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text,
                        );
                      } catch (error) {
                        setState(() {
                          if (error.toString() ==
                              '[firebase_auth/unknown] Given String is empty or null') {
                            errorMessage = 'Musisz uzupełnić pola';
                          } else if (error.toString() ==
                              '[firebase_auth/invalid-email] The email address is badly formatted.') {
                            errorMessage = 'Tak nie wygląda adres e-mail';
                          } else {
                            errorMessage = error.toString();
                          }
                        });
                      }
                    }
                  },
                  child: Text(isCreatingAccount == true
                      ? 'Zarejestruj się'
                      : 'Zaloguj się')),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text('Utwórz konto'),
                ),
              ] else if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: const Text('Masz juz konto?'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
