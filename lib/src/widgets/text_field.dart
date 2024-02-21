import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputField extends StatefulWidget {
   TextInputField({super.key,required this.hintText,required this.obscureText,required this.textInputType,required this.controller});
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
final TextEditingController controller;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
              keyboardType: widget.textInputType,
              obscureText: widget.obscureText,
              decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
              ),
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.w),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.w,
                )

              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.w),
                borderSide: BorderSide(color: Colors.black,
                  width: 1.w,
                )

              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.w),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.w,
                )

              ),
            ),);
  }
}