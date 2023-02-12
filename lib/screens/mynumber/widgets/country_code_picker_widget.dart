import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gatekeeper/utils/preference.dart';
import '../../../components/reusable_container.dart';
import '../../../constant/styles.dart';

class CountryCodePickerWidget extends StatefulWidget {
  const CountryCodePickerWidget({Key? key}) : super(key: key);

  @override
  State<CountryCodePickerWidget> createState() =>
      _CountryCodePickerWidgetState();
}

class _CountryCodePickerWidgetState extends State<CountryCodePickerWidget> {
  String countryCode = "SG";
  String phoneCode = "65";

  @override
  Widget build(BuildContext context) {
    SharedPrefs.setCountryCode(phoneCode);
    return InkWell(
      onTap: () {
        showCountryPicker(
            context: context,
            onClosed: () {},
            showPhoneCode: true,
            countryListTheme: CountryListThemeData(
                bottomSheetHeight: 400.h,
                borderRadius:  BorderRadius.all(Radius.circular(8.0.sp)),
                inputDecoration: const InputDecoration(
                  hintText: 'Start typing here',
                  labelText: 'Search ',
                )),
            onSelect: (Country value) {
              debugPrint(value.countryCode.toString());
              debugPrint(value.phoneCode.toString());

              countryCode = value.countryCode.toString();
              phoneCode = value.phoneCode.toString();
              SharedPrefs.setCountryCode(phoneCode);
              setState(() {});
            });
      },
      child: ReusableContainer(
        width: 99.w,
        height: 40.h,
        dBox: CommonStyle.textFieldDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(countryCode.toString(), style: CommonStyle.font14SpWeight500),
            SizedBox(
              width: 5.w,
            ),
            Text("+ ${phoneCode.toString()}",
                style: CommonStyle.font14SpWeight500),
            SizedBox(
              width: 5.w,
            ),
            SvgPicture.asset("assets/images/Vector.svg"),
          ],
        ),
      ),
    );
  }
}
