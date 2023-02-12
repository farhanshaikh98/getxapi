import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableButton extends StatelessWidget {
  const ReusableButton(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      required this.buttonColor});

  final String buttonName;
  final VoidCallback onPressed;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize:  Size(double.infinity, 50.0.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0.sp),
          )),
      child: Text(
        buttonName,
        style:  TextStyle(color: Colors.white, fontSize: 16.0.sp),
      ),
    );
  }
}
