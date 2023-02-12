import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/colors.dart';

class ReusableCircleAvatar extends StatelessWidget {
  final Widget? child;

  const ReusableCircleAvatar({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: CommonColor().colors[Random().nextInt(5)],
      child: child,
    );
  }
}
