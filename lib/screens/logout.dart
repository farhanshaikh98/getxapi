import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/screens/purpose/purpose_screen.dart';
import '../components/reusable_button.dart';
import '../constant/app_asset.dart';
import '../constant/styles.dart';
import '../services/api_manager.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/app_details.dart';
import '../utils/preference.dart';
import '../utils/validations.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  Future<APIResponse> onLogout() async {
    return await APIService.logout();
  }

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  TextEditingController mobileNumberController = TextEditingController();

  logoutHandle() async {
    ValidationUtils.showLoaderDialog(context: context);
    widget.onLogout().then((APIResponse response) {
      ValidationUtils.hideDialog(context: context);
      NavigationService(context: context).logout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 20,
          icon: SvgPicture.asset(
            AppAsset.arrowbackicon,
            height: MediaQuery.of(context).size.height*0.03,
            width: MediaQuery.of(context).size.width*0.03,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PurposeScreen()));
            },
            splashRadius: 20,
            icon: SvgPicture.asset(
              AppAsset.homeicon,
              height: MediaQuery.of(context).size.height*0.03,
              width: MediaQuery.of(context).size.width*0.03,
            ),
          ),
          SizedBox(
            width: 15.0.sp,
          ),
        ],
        titleSpacing: 0.0,
        title: Row(
          children: [
            Text(
              "Logout",
              style: CommonStyle.font16SpWeight500colorBlack,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 105.h,
              ),
              Text(ReusableString.worksiteName,
                  style: CommonStyle.font14SpWeight500),
              SizedBox(
                height: 14.h,
              ),
              Text(SharedPrefs.getWorkSite() ?? 'Test',
                  style: CommonStyle.font24SpWeight500),
              SizedBox(
                height: 134.h,
              ),
              ReusableButton(
                buttonColor: const Color(0xffFF003D),
                buttonName: ReusableString.logout,
                onPressed: () {
                  logoutHandle();
                },
              ),
              SizedBox(height: 25.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "App Version ${AppDetails.getAppVersion()} ",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                ),
              )
            ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
