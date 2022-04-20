import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/login/components/centre_part.dart';
import 'package:food_demo_app/pages/login/components/end_part.dart';
import 'package:food_demo_app/pages/login/components/login_auth_provider.dart';
import 'package:food_demo_app/pages/login/components/top_part.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visible = true;
  @override
  Widget build(BuildContext context) {
    LoginAuthProvider loginAuthProvider =
        Provider.of<LoginAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopPart(),
            CenterPart(
              email: email,
              password: password, 
              onPressed: () { 
                setState(() {
                  visible = !visible;
                });
               }, 
               icon:Icon(
                visible? Icons.visibility_off:Icons.visibility,
              ), 
              obscureText: visible,
            ),
            EndPart(
              onPressed: () {
                loginAuthProvider.loginPageValidation(
                    emailAddress: email, password: password, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
