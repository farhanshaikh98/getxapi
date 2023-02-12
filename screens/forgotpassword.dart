import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/utils/validations.dart';
import '../components/reusable_button.dart';
import '../components/reusable_textformfield.dart';
import '../constant/app_asset.dart';
import '../services/api_manager.dart';
import '../services/user_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  Future<APIResponse> onForgotPassword(String userName) async {
    return await APIService.passwordRest(userName);
  }

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController userNameController = TextEditingController();
  bool btnActivationStatus = false;
  final _forgotPasswordKey = GlobalKey<FormState>();

  validateFieldsEnter() {
    if (ValidationUtils.isFieldEmpty(userNameController.text)) {
      setState(() {
        btnActivationStatus = true;
      });
    } else {
      setState(() {
        btnActivationStatus = false;
      });
    }
  }

  forgotpasswordHandle() async {
    if (btnActivationStatus) {
      ValidationUtils.showLoaderDialog(context: context);
      widget
          .onForgotPassword(userNameController.text)
          .then((APIResponse response) {
        if (response.success == true) {
          ValidationUtils.hideDialog(context: context);
          ValidationUtils.showSnackBar(context, response.message.toString());
          Navigator.of(context).pop();
        } else {
          ValidationUtils.hideDialog(context: context);
          ValidationUtils.showSnackBar(context, response.message.toString());
        }
      });
    }
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
              height: MediaQuery.of(context).size.height * 0.03,
              width: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _forgotPasswordKey,
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
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      ReusableString.forgotpassword,
                      style: TextStyle(
                          fontSize: 24.0.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      ReusableString.username,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                    ReusableTextFormField(
                      contentPadding: EdgeInsets.all(8.0.sp),
                      textcapitalization: TextCapitalization.none,
                      obscureText: false,
                      onchange: (v) => validateFieldsEnter(),
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                      controller: userNameController,
                    ),
                    SizedBox(
                      height: 105.h,
                    ),
                    ReusableButton(
                        buttonColor: btnActivationStatus
                            ? const Color(0xffFF003D)
                            : const Color(0xFFAEAEAE),
                        buttonName: ReusableString.ForgotPassbuttonname,
                        onPressed: forgotpasswordHandle),
                    SizedBox(height: 25.h),
                  ],
                ),
              )),
        ));
  }
}
