import 'package:flutter/material.dart';

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
