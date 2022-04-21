import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/signup/sign_page.dart';
import 'package:food_demo_app/route/routing_page.dart';

import '../../../widgets/my_button.dart';

class EndPart extends StatelessWidget {
  final void Function()? onPressed;
  final bool loading;
  const EndPart({
    required this.onPressed,
    required this.loading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loading == true
            ? CircularProgressIndicator()
            : MyButton(
                onPressed: onPressed,
                text: "LOG IN",
              ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?\t\t\t\t"),
            GestureDetector(
              onTap: () {
                RoutingPage.goTonext(
              context: context,
              navigateTo: SignUpPage(),
            );
              },
              child: Text("SIGN UP"),
            ),
          ],
        ),
      ],
    );
  }
}
