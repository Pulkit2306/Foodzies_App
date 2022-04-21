import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/pages/login/login_page.dart';
import 'package:food_demo_app/pages/signup/sign_page.dart';
import 'package:food_demo_app/widgets/my_button.dart';

class EndPart extends StatelessWidget {
  const EndPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage(),
                  ),
                );
            },
            text: "LOG IN"),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUpPage(),
              ),
            );
          },
          child: Text(
            "SIGN UP",
            style: TextStyle(
              color: AppColors.KGradBlue
              ),
          ),
        ),
      ],
    );
  }
}
