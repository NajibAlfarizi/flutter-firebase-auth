// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var uid = '';
  var username = '';
  var messageError = '';
  bool obscurePassword = true;
  var loginState = StateLogin.initial;

  void Register(BuildContext context, VoidCallback onSucces) async {
    if (formKeyRegister.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
        showAlertSucces(context, 'Registration Success', uid, onSucces);
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }
    } else {
      showAlertError(context, 'Please fill all the fields');
    }

    notifyListeners();
  }

  void Login(BuildContext context) async {
    if (formKeyLogin.currentState!.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        User dataUser = result.user!;
        username = emailController.text;
        uid = dataUser.uid;
        loginState = StateLogin.success;
        showAlertSucces(context, 'Login Success', uid, () {
          Navigator.pop(context);
        });
      } on FirebaseAuthException catch (error) {
        loginState = StateLogin.error;
        messageError = error.message!;
        showAlertError(context, messageError);
      } catch (e) {
        loginState = StateLogin.error;
        messageError = e.toString();
        showAlertError(context, messageError);
      }
    } else {
      showAlertError(context, 'Please fill all the fields');
    }

    notifyListeners();
  }

  void actionObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

enum StateLogin { initial, success, error }

void showAlertSucces(
    BuildContext context, String message, String uid, VoidCallback onSucces) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              onSucces();
            },
          ),
        ],
      );
    },
  );
}

void showAlertError(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
