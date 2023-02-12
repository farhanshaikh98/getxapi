import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/constant/strings.dart';

import 'reusable_container.dart';

bool focus = false;

class ReusableTextFormField extends StatefulWidget {
  const ReusableTextFormField({
    super.key,
    this.margin,
    this.controller,
    this.emptyMassage,
    this.enabled,
    this.keyboardtype,
    this.maxline,
    this.hintext,
    this.onchange,
    this.validation,
    required this.textcapitalization,
    this.onFieldSubmitted,
    this.focusNode,
    this.fildlength,
    this.suffixstring,
    this.suffixstyle,
    this.suffixIcon,
    required this.obscureText,
    required this.contentPadding,
  });

  final EdgeInsets? margin;
  final TextEditingController? controller;
  final String? emptyMassage;
  final bool? enabled;
  final ValueChanged? onchange;
  final TextInputType? keyboardtype;
  final int? maxline;
  final String? suffixstring;
  final String? hintext;
  final String? Function(String?)? validation;
  final TextCapitalization textcapitalization;
  final Function? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? fildlength;
  final TextStyle? suffixstyle;
  final Widget? suffixIcon;
  final bool obscureText;
  final EdgeInsets? contentPadding;

  @override
  State<ReusableTextFormField> createState() => ReusableTextFormFieldState();
}

class ReusableTextFormFieldState extends State<ReusableTextFormField> {
  @override
  Widget build(BuildContext context) {
    return ReusableContainer(
      margin: widget.margin,
      child: TextFormField(
        textCapitalization: widget.textcapitalization,
        enabled: widget.enabled,
        onChanged: widget.onchange,
        obscureText: widget.obscureText,
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return widget.emptyMassage ?? ReusableString.fieldEmptyErrorMsg;
          } else {
            return null;
          }
        }),
        onFieldSubmitted: (String s) {
          widget.onFieldSubmitted!();
        },
        focusNode: widget.focusNode,
        autofocus: true,
        maxLines: widget.maxline ?? 1,
        controller: widget.controller,
        keyboardType: widget.keyboardtype,
        inputFormatters: widget.fildlength,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            suffixText: widget.suffixstring,
            suffixIconColor: Colors.red,
            suffixStyle: widget.suffixstyle,
            hintText: widget.hintext,
            suffixIcon: widget.suffixIcon,
            contentPadding: widget.contentPadding,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
              borderSide: BorderSide(
                width: 1.sp,
                color: const Color(0xffBDD1DC),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
              borderSide: BorderSide(
                width: 1.sp,
                color: const Color(0xffBDD1DC),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
              borderSide: BorderSide(
                width: 1.sp,
                color: const Color(0xffBDD1DC),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
              borderSide: BorderSide(
                width: 1.sp,
                color: const Color(0xffBDD1DC),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0.sp)),
              borderSide: BorderSide(
                width: 1.sp,
                color: Color(0xffBDD1DC),
              ),
            ),
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
