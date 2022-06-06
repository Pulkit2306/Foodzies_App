import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/pages/welcome/welcome_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navitagetohome();
  }

  _navitagetohome() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            height: 100,
            width: 100,
            child: Image.asset("Assets/Images/logo.jpeg"),
            ),
          color: AppColors.KGradient1,
        ),
      ),
    );
  }
}
