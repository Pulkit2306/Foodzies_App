import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';

class SingleCartItem extends StatelessWidget {

  final String productImage;
  final String productTitle;
  final double productPrice;
  final int productQuantity;




  const SingleCartItem({Key? key,

  required this.productImage,
  required this.productTitle,
  required this.productPrice,
  required this.productQuantity,
  
  
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 7),
        ],
        // image: DecorationImage(
        //   image: AssetImage("Assets/Images/logo.jpeg"),
        // ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(productImage),
                ),
              ),
            ),
          ),
          Expanded(
            // flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    productTitle,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Fast Foods",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "\$$productPrice",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IncrementAndDecrement(onPressed: () {}, icon: Icons.add),
                      // SizedBox(width: 25,),
                      Text(productQuantity.toString(),
                      style: TextStyle(
                        fontSize: 18,
                       ),
                      ),
                      IncrementAndDecrement(
                          onPressed: () {}, icon: Icons.remove),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const IncrementAndDecrement({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      onPressed: onPressed,
      color: AppColors.KGradient1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: AppColors.KWhite,
      ),
    );
  }
}
