import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.black,
      ),
    );
  }
}
