import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(const LoginState(
          errorMessage: "",
          isCreatingAccount: false,
        ));
  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      if (error.toString() == '[firebase_auth/unknown] Given String is empty or null') {
        emit(const LoginState(
          errorMessage: 'Musisz uzupełnić pola',
          isCreatingAccount: false,
        ));
      } else if (error.toString() == '[firebase_auth/invalid-email] The email address is badly formatted.') {
        emit(const LoginState(
          errorMessage: 'Tak nie wygląda adres e-mail',
          isCreatingAccount: false,
        ));
      } else {
        emit(LoginState(
          errorMessage: error.toString(),
          isCreatingAccount: false,
        ));
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      if (error.toString() == '[firebase_auth/unknown] Given String is empty or null') {
        emit(const LoginState(
          errorMessage: 'Musisz uzupełnić pola',
          isCreatingAccount: false,
        ));
      } else if (error.toString() == '[firebase_auth/invalid-email] The email address is badly formatted.') {
        emit(const LoginState(
          errorMessage: 'Tak nie wygląda adres e-mail',
          isCreatingAccount: false,
        ));
      } else if (error.toString() == '[firebase_auth/weak-password] Password should be at least 6 characters') {
        emit(const LoginState(
          errorMessage: 'Hasło musi składać się przynajmniej z 6 znaków',
          isCreatingAccount: false,
        ));
      } else {
        emit(LoginState(
          errorMessage: error.toString(),
          isCreatingAccount: false,
        ));
      }
    }
  }

  Future<void> start() async {
    emit(
      const LoginState(
        isCreatingAccount: false,
        errorMessage: "",
      ),
    );
  }

  Future<void> setState() async {
    emit(
      const LoginState(
        isCreatingAccount: true,
        errorMessage: "",
      ),
    );
  }
}
