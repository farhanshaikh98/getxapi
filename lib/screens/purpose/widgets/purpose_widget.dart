import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../components/reusable_container.dart';

class PurposeWidget extends StatefulWidget {
  const PurposeWidget(
      {super.key,
      required this.purposeIcon,
      required this.purposeString,
      required this.index,
      required this.onSelect});

  final String purposeIcon;
  final String purposeString;
  final String index;
  final VoidCallback onSelect;

  @override
  State<PurposeWidget> createState() => _PurposeWidgetState();
}

class _PurposeWidgetState extends State<PurposeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect,
      child: ReusableContainer(
        margin: EdgeInsets.only(bottom: 12.sp),
        width: double.infinity,
        height: 50.sp,
        dBox: BoxDecoration(
            color: widget.index == widget.purposeString
                ? const Color(0xff2A70FF)
                : const Color(0xffF8F9FB),
            // color: Colors.red,

            borderRadius: BorderRadius.circular(10.sp)),
        child: Row(
          children: [
            const SizedBox(
              width: 12.0,
            ),
            SvgPicture.asset(
              widget.purposeIcon,width: 20.0.sp,height: 20.0.sp,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Text(
              widget.purposeString,
              style: GoogleFonts.sora(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: widget.index == widget.purposeString
                      ? Colors.white
                      : Colors.black),
            ),
            const Spacer(),
            widget.index == widget.purposeString
                ? Image.asset(
                    "assets/purposeicons/selectpurpose.png",height: 20.0.sp,width: 20.0.sp,
                  )
                : Container(),
            SizedBox(
              width: 21.w,
            )
          ],
        ),
      ),
    );
  }
}
