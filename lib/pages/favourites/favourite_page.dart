import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/widgets/grid_view_widget.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridViewWidget(
          collection: "favorite",
          subCollection: "userFavorite",
          id: FirebaseAuth.instance.currentUser!.uid,
        ),
      ),
    );
  }
}
