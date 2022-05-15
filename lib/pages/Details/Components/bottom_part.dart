import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/widgets/my_button.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Name",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                "\$40",
                style: TextStyle(),
              ),
              SizedBox(
                width: 7.5,
              ),
              Text(
                "\$47",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.KGradient2,
                    ),
                    child: Center(
                      child: Text(
                        "4.5",
                        style: TextStyle(
                          color: AppColors.KWhite,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Reviews",
                    style: TextStyle(
                      color: AppColors.KGradient2,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
          Text(
            "About the Dish",
            style: TextStyle(
              color: AppColors.KGradient1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
          MyButton(
            onPressed: () {},
            text: "Add To Cart",
          ),
        ],
      ),
    );
  }
}
