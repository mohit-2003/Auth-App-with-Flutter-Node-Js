import 'dart:convert';

import 'package:auth_app/constants.dart';
import 'package:auth_app/models/user.dart';
import 'package:auth_app/session/session.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<String> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = new User(name: name, email: email, password: password);
      http.Response response = await http.post(
          Uri.parse("${Constant.apiUrl}${Constant.signup}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: user.toJson());
      switch (response.statusCode) {
        case 200:
          return "Account created successfully..";
        case 400:
        case 500:
          return jsonDecode(response.body)["error"];
        default:
          return "Something went wrong, try again";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> signIn(
      {required String email, required String password}) async {
    try {
      final user = new User(name: "", email: email, password: password);
      http.Response response = await http.post(
          Uri.parse("${Constant.apiUrl}${Constant.signin}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: user.toJson());

      final map = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
          await Session.setString(Constant.username, map["name"]);
          await Session.setString(Constant.email, map["email"]);
          await Session.setString(Constant.token, map["token"]);
          return "Logged in successfully..";
        case 400:
        case 500:
          return jsonDecode(response.body)["error"];
        default:
          return "Something went wrong, try again";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
