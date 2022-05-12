import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;


  const SingleProduct({

    required this.image,
    required this.price,
    required this.name,
    
    
    
    
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(12),
          height: 250,
          width: 180,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            // left: 23,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "\$$price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              
            ],
          ),
        ),
      ],
    );
  }
}
