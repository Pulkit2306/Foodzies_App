import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "Assets/Images/logo.jpeg",
                scale: 5,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "LOGIN",
              style: TextStyle(
                color: AppColors.VBlack,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
