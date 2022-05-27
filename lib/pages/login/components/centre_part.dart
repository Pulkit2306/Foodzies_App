import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/forgetPassword/forget_password.dart';
import 'package:food_demo_app/route/routing_page.dart';

class CenterPart extends StatelessWidget {
  final TextEditingController? email;
  final TextEditingController? password;
  final bool obscureText;
  final Widget icon;
  final void Function()? onPressed;
  CenterPart({
    required this.icon,
    required this.email,
    required this.password,
    required this.onPressed,
    required this.obscureText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'Email ',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.email_rounded),
            ),
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: password,
          decoration: InputDecoration(
            counter: GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
                  context: context,
                  navigateTo: ForgotPassword(),
                );
              },
              child: Text("Forgot Password?",
              style: TextStyle(
                color: Colors.blue,
              ),
              ),
            ),
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ),
      ],
    );
  }
}
