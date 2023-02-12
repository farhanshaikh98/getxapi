import 'package:flutter/material.dart';

class ReusableContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? dBox;

  const ReusableContainer(
      {Key? key,
      this.width = double.infinity,
      this.height,
      this.child,
      this.padding,
      this.margin,
      this.dBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      decoration: dBox,
      child: child,
    );
  }
}
