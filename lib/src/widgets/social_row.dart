import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget socialRow(){
 return Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/facebook.png'),fit: BoxFit.cover
        ),
      ),
      
    ),
    Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/google.png'),fit: BoxFit.cover
        ),
      ),
      
    ),
    Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage('assets/apple.png'),fit: BoxFit.cover
        ),
      ),
     
    )
  ],
 );
}