import 'package:auth_app/screens/signup_screen.dart';
import 'package:auth_app/services/auth_services.dart';
import 'package:auth_app/widgets/custom_button.dart';
import 'package:auth_app/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: new Form(
            key: _formKey,
            child: new ListView(
              shrinkWrap: true,
              children: [
                new Container(
                  padding: EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  child: new Text(
                    "Login",
                    style: new TextStyle(
                        color: Colors.green[800],
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0),
                  ),
                ),
                new CustomTextFormField(
                    hintText: "Enter your email", controller: _emailController),
                new SizedBox(
                  height: 8,
                ),
                new CustomTextFormField(
                    hintText: "Enter your password",
                    isPassword: true,
                    controller: _passwordController),
                new SizedBox(
                  height: 16,
                ),
                new CustomButton(
                    text: "Log in",
                    onTap: () {
                      validateAndLogin();
                    }),
                new Container(
                    margin: EdgeInsets.only(top: 16),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("Don't have any account?"),
                          new TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(
                                  builder: (context) => new SignupScreen(),
                                ));
                              },
                              child: new Text(
                                "Sign up",
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ))
                        ]))
              ],
            )),
      ),
    );
  }

  void validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      // login
      final email = _emailController.text;
      final password = _passwordController.text;
      final String res =
          await AuthServices.signIn(email: email, password: password);
      ScaffoldMessenger.of(context)
          .showSnackBar(new SnackBar(content: new Text(res)));
      if (res.contains("successfully")) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (context) => new HomeScreen(),
        ));
      }
    }
  }
}
