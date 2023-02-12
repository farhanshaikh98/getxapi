import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../constant/app_asset.dart';
import '../screens/purpose/purpose_screen.dart';

class ReusableAppbar extends StatelessWidget {
  const ReusableAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        splashRadius: 20,
        icon: SvgPicture.asset(
          height: MediaQuery.of(context).size.height*0.03,
          width: MediaQuery.of(context).size.width*0.03,
          AppAsset.arrowbackicon,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const PurposeScreen()),
                (Route<dynamic> route) => false);
          },
          splashRadius: 2 + 0,
          icon: SvgPicture.asset(
            height: MediaQuery.of(context).size.height*0.03,
            width: MediaQuery.of(context).size.width*0.03,
            AppAsset.homeicon,
          ),
        ),
      ],
    );
  }
}
