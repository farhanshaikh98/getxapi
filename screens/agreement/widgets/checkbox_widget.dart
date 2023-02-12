import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget(
      {super.key, required this.selected, required this.onCheck});

  final bool selected;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCheck,
      child: Container(
        height: 30.sp,
        width: 30.sp,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0.sp),
            color: selected ? const Color(0xff2A70FF) : Colors.white,
            border: Border.all(width: 2, color: const Color(0xff2A70FF))),
        child: Padding(
            padding:  EdgeInsets.all(3.0.sp),
            child: selected
                ? SvgPicture.asset(
                    "assets/images/check.svg",
                  )
                : Container()),
      ),
    );
  }
}
