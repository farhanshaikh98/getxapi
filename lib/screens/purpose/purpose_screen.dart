import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/constant/app_asset.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/screens/data_records.dart';
import 'package:gatekeeper/screens/purpose/widgets/purpose_widget.dart';
import 'package:gatekeeper/services/api_manager.dart';
import 'package:gatekeeper/services/navigation_service.dart';
import 'package:gatekeeper/utils/preference.dart';
import 'package:gatekeeper/utils/validations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/reusable_button.dart';
import '../../model/visitors_model.dart';
import '../../services/user_service.dart';

class PurposeScreen extends StatefulWidget {
  const PurposeScreen({super.key});

  Future<APIResponse> onWorkSiteName() async {
    return await APIService.getWorkSiteName();
  }

  Future<APIResponse> onLatestCar() async {
    return await APIService.getLatestCar();
  }

  Future<APIResponse> onActiveVisitors() async {
    return await APIService.getActivateVisitors();
  }

  @override
  State<PurposeScreen> createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen> {
  String option = '';
  List<GetActiveVisitors> _getActiveVisitors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWorksite();
  }

  getWorksite() {
    if (SharedPrefs.getWorkSite() == null) {
      widget.onWorkSiteName().then((APIResponse response) {
        if (response.success == true) {
          SharedPrefs.setWorkSite(response.data['name'].toString());
          SharedPrefs.setAgreement(response.data['agreement'].toString());
        } else {
          ValidationUtils.showSnackBar(context, response.message.toString());
        }
      });
    } else {
      debugPrint('Worksite is stored');
    }
  }

  getLatestCar() {
    ValidationUtils.showLoaderDialog(context: context);
    widget.onLatestCar().then((APIResponse response) {
      if (response.success == true) {
        if (response.data != null) {
          SharedPrefs.setCarPlateNo(response.data['car_plate: '].toString());
          SharedPrefs.setMobileNumber(response.data['mobile'].toString());
        } else {
          SharedPrefs.setCarPlateNo("null");
        }
        ValidationUtils.hideDialog(context: context);
        NavigationService(context: context).gocarPlate();
      } else {
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  getActiveVisitors() {
    ValidationUtils.showLoaderDialog(context: context);
    widget.onActiveVisitors().then((APIResponse response) async {
      if (response.success == true) {
        _getActiveVisitors = List<GetActiveVisitors>.from(
          response.data.map(
            (json) => GetActiveVisitors.fromJson(json),
          ),
        );
        _getActiveVisitors.reversed.toList();
        if (_getActiveVisitors.isEmpty) {
          ValidationUtils.hideDialog(context: context);
          ValidationUtils.showSnackBar(context, "No active visitor.");
        } else {
          debugPrint(_getActiveVisitors[0].toString());
          ValidationUtils.hideDialog(context: context);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DataRecordsScreen(
                      getActiveVisitors: _getActiveVisitors,
                    )),
          );
        }
      } else {
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  VoidCallback selectPurpose(String purpose) {
    return () {
      setState(() {
        option = purpose;
        getLatestCar();
        SharedPrefs.setPurpose(purpose);
      });
    };
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
            NavigationService(context: context)
                .goToPage(GateKeeperPages.logout);
          },
          splashRadius: 20,
          icon: SvgPicture.asset(
            AppAsset.drawericon,
            height: 15.0.sp,
            width: 15.0.sp,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              ReusableString.purpose,
              style: GoogleFonts.sora(
                  fontWeight: FontWeight.w500, fontSize: 24.sp),
            ),
            SizedBox(
              height: 30.h,
            ),
            PurposeWidget(
                purposeIcon: AppAsset.deliveryicon,
                purposeString: ReusableString.delivery,
                onSelect: selectPurpose(ReusableString.delivery),
                index: option),
            PurposeWidget(
                purposeIcon: AppAsset.pickupicon,
                purposeString: ReusableString.pickup,
                onSelect: selectPurpose(ReusableString.pickup),
                index: option),
            PurposeWidget(
                purposeIcon: AppAsset.caricon,
                purposeString: ReusableString.dropoff,
                onSelect: selectPurpose(ReusableString.dropoff),
                index: option),
            PurposeWidget(
                purposeIcon: AppAsset.contractoricon,
                purposeString: ReusableString.contractor,
                onSelect: selectPurpose(ReusableString.contractor),
                index: option),
            PurposeWidget(
                purposeIcon: AppAsset.visitoricon,
                purposeString: ReusableString.visitor,
                onSelect: selectPurpose(ReusableString.visitor),
                index: option),
            PurposeWidget(
                purposeIcon: AppAsset.othericon,
                purposeString: ReusableString.other,
                onSelect: selectPurpose(ReusableString.other),
                index: option),
            SizedBox(
              height: 40.h,
            ),
            ReusableButton(
                buttonColor: const Color(0xffFF003D),
                buttonName: 'Checkout',
                onPressed: () {
                  getActiveVisitors();
                })
          ]),
        ),
      ),
    );
  }
}
