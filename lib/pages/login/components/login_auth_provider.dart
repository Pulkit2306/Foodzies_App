import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/home/home_page.dart';
import 'package:food_demo_app/route/routing_page.dart';

class LoginAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(LoginAuthProvider.pattern.toString());

  bool loading = false;

  UserCredential? userCredential;

  void loginPageValidation({
    required TextEditingController? emailAddress,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (emailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide your Email Address.")),
      );
      return;
    } else if (!regExp.hasMatch(emailAddress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email address.")),
      );
      return;
    } else if (password!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please set your password.")),
      );
      return;
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Please too short, must be atleast 8 characters long..")),
      );
      return;
    } else {
      try {
        loading = true;
        notifyListeners();

        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        )
            .then((value) async {
              loading = false;
              notifyListeners();
              await RoutingPage.goTonext(
              context: context,
              navigateTo: HomePage(),
            );
          return null;
          }
        );
        notifyListeners();
      } on FirebaseAuthException catch(e) {
        loading = false;
        notifyListeners();
        if(e.code == "user-not-found"){
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User_Not_Found")),
      );
        }else if(e.code == "wrong-password"){
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect Password")),
      );
        }
      }
    }
  }
}
