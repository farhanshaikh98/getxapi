import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableSkipTextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ReusableSkipTextButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text("SKIP",
          style: GoogleFonts.sora(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black)),
    );
  }
}
