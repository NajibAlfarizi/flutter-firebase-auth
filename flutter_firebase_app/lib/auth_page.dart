// ignore_for_file: sort_child_properties_last, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'controller/auth_Controller.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoginPage = false;

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthController>();
    return Scaffold(
      body: Form(
        key: isLoginPage
            ? authProvider.formKeyLogin
            : authProvider.formKeyRegister,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: ListView(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/images/msib.png",
                      width: 325,
                      height: 325,
                    ),
                  ],
                ),
              ),
              Text('Selamat Datang di Platform MSIB',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              Padding(padding: EdgeInsets.only(bottom: 24)),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                controller: authProvider.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                key: ValueKey('password'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                controller: authProvider.passwordController,
                obscureText: authProvider.obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      context.read<AuthController>().actionObscurePassword();
                    },
                    icon: Icon(authProvider.obscurePassword == true
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width / 10,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  if (isLoginPage) {
                    context.read<AuthController>().Login(context);
                  } else {
                    context.read<AuthController>().Register(
                      context,
                      () {
                        setState(() {
                          isLoginPage = true;
                        });
                      },
                    );
                  }
                },
                child: Text(
                  isLoginPage ? 'Login' : 'Register',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.infinity, 48),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLoginPage = !isLoginPage;
                  });
                },
                child: Text(
                  isLoginPage
                      ? 'Don\'t have an account? Register'
                      : 'Already have an account? Login',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
