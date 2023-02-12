import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/screens/agreement/non_disclosure_agreement_screen.dart';
import 'package:gatekeeper/screens/blocknumber/block_number.dart';
import 'package:gatekeeper/screens/car_plate.dart';
import 'package:gatekeeper/screens/data_records.dart';
import 'package:gatekeeper/screens/forgotpassword.dart';
import 'package:gatekeeper/screens/login.dart';
import 'package:gatekeeper/screens/logout.dart';
import 'package:gatekeeper/screens/my_name_id_screen.dart';
import 'package:gatekeeper/screens/mynumber/my_number_screen.dart';
import 'package:gatekeeper/screens/profile.dart';
import 'package:gatekeeper/screens/purpose/purpose_screen.dart';
import 'package:gatekeeper/screens/splash.dart';
import 'package:gatekeeper/services/navigation_service.dart';
import 'package:gatekeeper/utils/app_details.dart';
import 'package:gatekeeper/utils/preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPrefs instance.
  await SharedPrefs.init();
  await AppDetails.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ReusableString.appNameTxt,
          routes: {
            GateKeeperPages.splash: (context) => const SplashScreen(),
            GateKeeperPages.login: (context) => const LoginScreen(),
            GateKeeperPages.purpose: (context) => const PurposeScreen(),
            GateKeeperPages.agreement: (context) => const AgreementScreen(),
            GateKeeperPages.profile: (context) => ProfileScreen(),
            GateKeeperPages.carPlate: (context) => const CarPlateScreen(),
            GateKeeperPages.myNameId: (context) => MyNameIdScreen(),
            GateKeeperPages.dataRecord: (context) => DataRecordsScreen(),
            GateKeeperPages.blocNumber: (context) => BlockNumberScreen(),
            GateKeeperPages.myNumber: (context) => const MyNumberScreen(),
            GateKeeperPages.logout: (context) => const LogoutScreen(),
            GateKeeperPages.forgotPassword: (context) =>
                const ForgotPasswordScreen(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
