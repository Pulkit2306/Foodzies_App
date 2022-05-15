import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/Details/Components/bottom_part.dart';
import 'package:food_demo_app/pages/Details/Components/top_part.dart';


class DetailsPage extends StatelessWidget {
  const DetailsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(),

            BottomPart(),
            
            
          ],
        ),
      ),
    );
  }
}