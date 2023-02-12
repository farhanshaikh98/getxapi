import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatekeeper/constant/app_asset.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/services/navigation_service.dart';
import 'package:gatekeeper/services/user_service.dart';
import 'package:gatekeeper/utils/colors.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../components/reusable_container.dart';
import '../services/api_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  Future<APIResponse> onConnectionCheck() async {
    return await APIService.checkConnection();
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    validateLogin();
  }

  jumpToLogin() => WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          NavigationService(context: context)
              .goToPageAndReplace(GateKeeperPages.login);
        });
      });

  validateLogin() async {
    if (SharedPrefs.getAccessToken() != null) {
      debugPrint('check token is not null in preference');
      widget.onConnectionCheck().then((APIResponse response) async {
        debugPrint('call onConnectionCheck api');
        if (response.success == true) {
          debugPrint('token is not null goto Purpose page');
          NavigationService(context: context).goPurpose();
        } else {
          Fluttertoast.showToast(
            msg: response.message!,
            toastLength: Toast.LENGTH_LONG,
            fontSize: 16.0,
          );
          jumpToLogin();
        }
      });
    } else {
      debugPrint('token is null goto login page');
      jumpToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    var mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ReusableContainer(
        width: double.infinity,
        height: double.infinity,
        dBox: const BoxDecoration(color: CommonColor.primarySplashColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                AppAsset.splashtopimage,
                height: mHeight * 0.20,

              ),
            ),
            SizedBox(
              height: mHeight * 0.14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.splashlogo,
                ),
                SizedBox(
                  width: 5.h,
                ),
                Column(
                  children: [
                    Text(
                      ReusableString.appName,
                      style: TextStyle(color: Colors.white, fontSize: 32.sp),
                    ),
                    Text(
                      ReusableString.appTitle,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  AppAsset.splashbottomimage,
                  height: mHeight * 0.14,
                ),
                Image.asset(
                  AppAsset.splashlogowatermark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
