import 'package:auth_app/screens/home_screen.dart';
import 'package:auth_app/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = new TextEditingController();
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
                    "Signup",
                    style: new TextStyle(
                        color: Colors.green[800],
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0),
                  ),
                ),
                new CustomTextFormField(
                    hintText: "Enter your name", controller: _nameController),
                new SizedBox(
                  height: 8,
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
                    text: "Sign up",
                    onTap: () {
                      validateAndSignup();
                    }),
                new Container(
                    margin: EdgeInsets.only(top: 16),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("Already have an account?"),
                          new TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: new Text(
                                "Log in",
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

  void validateAndSignup() async {
    if (_formKey.currentState!.validate()) {
      // login
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      String res = await AuthServices.signUp(
          name: name, email: email, password: password);
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
