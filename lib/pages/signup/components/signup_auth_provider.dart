import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/home/home_page.dart';

class SignupAuthProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(SignupAuthProvider.pattern.toString());

  UserCredential? userCredential;

  bool loading = false;

  void signupValidation({
    required TextEditingController? fullname,
    required TextEditingController? age,
    required TextEditingController? contactNumber,
    required TextEditingController? emailAddress,
    required TextEditingController? password,
    required BuildContext context,
  }) async {
    if (fullname!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide your full name.")),
      );
      return;
    } else if (age!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide your present age.")),
      );
      return;
    } else if (age.text.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid age.")),
      );
      return;
    } else if (contactNumber!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide your contact number.")),
      );
      return;
    } else if (emailAddress!.text.trim().isEmpty) {
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
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: password.text,
        );

        loading = true;
        notifyListeners();
        FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential!.user!.uid)
            .set(
          {
            "FullName": fullname.text,
            "Age": age.text,
            "Contact": contactNumber.text,
            "emailAddress": emailAddress.text,
            "Passsword": password.text,
            "UserUid": userCredential!.user!.uid
          },
        ).then((value) {
          loading = false;
          notifyListeners();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
        );
      } on FirebaseAuthException catch(e){
        loading = false;
        notifyListeners();
        if(e.code == "Weak-Password!"){
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Weak-Password!"),
        ),
      );
        } else if(e.code == "Email-already-in-use!"){         
          ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email-already-in-use!"),
        ),
      );
        }
      }
    }
  }
}
