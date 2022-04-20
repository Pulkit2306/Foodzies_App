import 'package:flutter/material.dart';

import '../../../widgets/my_button.dart';

class EndPart extends StatelessWidget {
  final void Function()? onPressed;
  const EndPart({
    required this.onPressed,
    Key? key,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onPressed: onPressed,
          text: "LOG IN",
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?\t\t\t\t"),
            Text("SIGN UP"),
          ],
        ),
      ],
    );
  }
}
