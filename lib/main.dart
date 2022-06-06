import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/login/components/login_auth_provider.dart';
import 'package:food_demo_app/pages/signup/components/signup_auth_provider.dart';
import 'package:food_demo_app/pages/theme/theme.dart';
import 'package:food_demo_app/pages/welcome/welcome_page.dart';
import 'package:food_demo_app/provider/cart_provider.dart';
import 'package:food_demo_app/provider/favorite_provider.dart';
import 'package:food_demo_app/splash%20screen/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignupAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
       home: SplashScreen(),
        // home: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, userSnapshot) {
        //       if (userSnapshot.hasData) {
        //         return HomePage();
        //       }
        //       return WelcomePage();
        //     },
        //     ),
      ),
    );
  }
}
