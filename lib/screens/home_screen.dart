import 'package:auth_app/constants.dart';
import 'package:auth_app/session/session.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  @override
  void initState() {
    Session.getString(Constant.username).then((value) {
      setState(() {
        username = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text(
          "Hello, $username",
          style: new TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
