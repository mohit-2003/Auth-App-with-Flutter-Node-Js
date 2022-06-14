import 'package:flutter/material.dart';

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
      appBar: new AppBar(
        title: new Text("Login"),
        leading: new Icon(Icons.person_outline_outlined),
        titleSpacing: 0,
        elevation: 0,
      ),
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
                getTextFormField(
                    hintText: "Enter your email", controller: _emailController),
                new SizedBox(
                  height: 8,
                ),
                getTextFormField(
                    hintText: "Enter your password",
                    isPassword: true,
                    controller: _passwordController),
                new SizedBox(
                  height: 16,
                ),
                getButton("Log in", () {
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
                                print("Signup");
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

  Widget getTextFormField(
      {required String hintText,
      bool isPassword = false,
      required TextEditingController controller}) {
    return new TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please ${hintText.replaceRange(0, 1, hintText[0].toLowerCase())}";
        }
        return null;
      },
      obscureText: isPassword,
      obscuringCharacter: "*",
      decoration: new InputDecoration(
          hintText: hintText,
          border: new OutlineInputBorder(),
          errorBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.red))),
    );
  }

  Widget getButton(String text, VoidCallback? onTap) {
    return new ElevatedButton(
        onPressed: onTap,
        child: new Container(
          margin: EdgeInsets.all(16),
          child: new Text(
            "Log in",
            style: new TextStyle(fontSize: 16),
          ),
        ));
  }

  void validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      // login
      final email = _emailController.text;
      final password = _passwordController.text;
      print("$email - $password");
    }
  }
}
