import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/utils/colors.dart';
import 'package:gatekeeper/utils/preference.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(
      {super.key,
      required this.itemList,
      this.boxDecoration,
      this.buttonElevation,
      required this.checkPurpose,
      required this.dropdbuttonwidth,
      required this.dropdownwidth,
      this.dropdbuttonheight});

  final List<String> itemList;
  final String checkPurpose;
  final BoxDecoration? boxDecoration;
  final int? buttonElevation;
  final double dropdbuttonwidth;
  final double dropdownwidth;
  final double? dropdbuttonheight;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: DropdownButton2(
          hint: Text(
            SharedPrefs.getActiveVisitor().toString() == 'notnull' &&
                    widget.checkPurpose == "blocknumber"
                ? SharedPrefs.getBlockNumber().toString()
                : widget.itemList[0].toString(),
            style: TextStyle(
              color: CommonColor.textFieldColor,
              fontSize: ScreenUtil().setSp(15),
            ),
          ),
          items: widget.itemList
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        color: CommonColor.textFieldColor,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                  ))
              .toList(),
          scrollbarThickness: 4.0,
          value: selectedValue,
          itemHeight: 25.0.sp,
          icon: SvgPicture.asset("assets/images/chevron-down.svg"),
          buttonHeight: widget.dropdbuttonheight ?? 36.h,
          // mheight / 17,
          buttonDecoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0.h),
            border: Border.all(
              width: 1.sp,
              color: CommonColor.borderColor,
            ),
            color: Colors.white,
          ),
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0.h),
          ),
          buttonPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          buttonWidth: widget.dropdbuttonwidth,
          dropdownWidth: widget.dropdownwidth,
          dropdownMaxHeight: 120.0.h,
          dropdownPadding: EdgeInsets.all(8.0.sp),
          onChanged: (String? value) {
            setState(() {
              selectedValue = value!;
              if (widget.checkPurpose == "blocknumber") {
                SharedPrefs.setBlockNumber(selectedValue.toString());
              } else if (widget.checkPurpose == "duration") {
                SharedPrefs.setDuration(selectedValue.toString());
              }
            });
          },
        ),
      ),
    );
  }
}
