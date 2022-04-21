import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/login/login_page.dart';
import 'package:food_demo_app/pages/signup/components/signup_auth_provider.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/my_button.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController emailAdress = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    SignupAuthProvider signupauthprovider =
        Provider.of<SignupAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: fullname,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.numbers_outlined),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: contactNumber,
                    decoration: InputDecoration(
                      hintText: 'Contact Number',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: emailAdress,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.email_rounded),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: visibility,
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: Icon(
                          visibility ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  signupauthprovider.loading == false
                      ? MyButton(
                          onPressed: () {
                            signupauthprovider.signupValidation(
                              fullname: fullname,
                              age: age,
                              contactNumber: contactNumber,
                              emailAddress: emailAdress,
                              password: password,
                              context: context,
                            );
                          },
                          text: "SIGN UP")
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an Account?\t\t\t\t"),
                      GestureDetector(
                        onTap: () {
                          RoutingPage.goTonext(
                            context: context,
                            navigateTo: LoginPage(),
                          );
                        },
                        child: Text("LOG IN"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
