import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/screens/forgotpassword.dart';
import 'package:gatekeeper/utils/app_details.dart';
import 'package:gatekeeper/utils/colors.dart';
import 'package:gatekeeper/utils/preference.dart';
import 'package:gatekeeper/utils/validations.dart';
import '../components/reusable_button.dart';
import '../components/reusable_textformfield.dart';
import '../constant/app_asset.dart';
import '../services/api_manager.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  Future<APIResponse> onLogIn(String userName, String password) async {
    return await APIService.login(userName, password);
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool btnActivationStatus = false;
  final _loginKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  validateFieldsEnter() {
    if (ValidationUtils.isFieldEmpty(usernameController.text) &&
        ValidationUtils.isFieldEmpty(passwordController.text)) {
      setState(() {
        btnActivationStatus = true;
      });
    } else {
      setState(() {
        btnActivationStatus = false;
      });
    }
  }

  loginHandle() async {
    if (btnActivationStatus) {
      ValidationUtils.showLoaderDialog(context: context);
      widget
          .onLogIn(usernameController.text, passwordController.text)
          .then((APIResponse response) {
        if (response.success == true) {
          SharedPrefs.setUserName(usernameController.text.trim());
          SharedPrefs.setAccessToken(response.data['token'].toString());

          NavigationService(context: context).goPurpose();
        } else {
          ValidationUtils.hideDialog(context: context);
          ValidationUtils.showSnackBar(
              context, ReusableString.loginErrorMsg.toString());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 60.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppAsset.applogo,
                      height: 74.h,
                      width: 75.w,
                    ),
                  ),
                ),
                Text(
                  ReusableString.login,
                  style:
                      TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  ReusableString.username,
                  style:
                      TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400),
                ),
                ReusableTextFormField(
                  contentPadding: EdgeInsets.all(8.0.sp),
                  textcapitalization: TextCapitalization.none,
                  onchange: (v) => validateFieldsEnter(),
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  controller: usernameController,
                  obscureText: false,
                ),
                Text(
                  ReusableString.password,
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
                ),
                ReusableTextFormField(
                  contentPadding: EdgeInsets.all(8.0.sp),
                  textcapitalization: TextCapitalization.none,
                  onchange: (v) => validateFieldsEnter(),
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  controller: passwordController,
                  obscureText: obscureText,
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      // color: CommonColor.splashColor,
                      size: 20.h,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        NavigationService(context: context).forgotPassword();
                      },
                      child: Text(
                        ReusableString.ForgotPassword,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400),
                      ),
                    )),
                SizedBox(
                  height: 105.h,
                ),
                ReusableButton(
                    buttonColor: btnActivationStatus
                        ? const Color(0xffFF003D)
                        : const Color(0xFFAEAEAE),
                    buttonName: "Login",
                    onPressed: loginHandle),
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
              ],
            ),
          )),
    ));
  }
}
