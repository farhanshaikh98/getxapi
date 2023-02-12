import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/utils/preference.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/reusable_appbar.dart';
import '../components/reusable_button.dart';
import '../components/reusable_textformfield.dart';
import '../components/skip_button.dart';
import '../constant/styles.dart';
import '../services/api_manager.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/validations.dart';
import 'blocknumber/block_number.dart';
import 'mynumber/widgets/country_code_picker_widget.dart';

class CarPlateScreen extends StatefulWidget {
  const CarPlateScreen({super.key});

  Future<APIResponse> onMobileNumber(String carPlateNo) async {
    return await APIService.getMobileNumber(carPlateNo);
  }

  Future<APIResponse> onBlockNumber() async {
    return await APIService.getBlocNumber();
  }

  Future<APIResponse> onPersonDetails(String mobilenumberwithcountry) async {
    return await APIService.getPersonDetails(mobilenumberwithcountry);
  }

  @override
  State<CarPlateScreen> createState() => _CarPlateScreenState();
}

class _CarPlateScreenState extends State<CarPlateScreen> {
  TextEditingController carPlateNumberController = TextEditingController();

  bool btnActivationStatus = false;
  final _carPlateKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getManualCarInData();
  }

  getManualCarInData() {
    setState(() {
      if (SharedPrefs.getCarPlateNo() != 'null' &&
          SharedPrefs.getCarPlateNo().toString().isNotEmpty) {
        carPlateNumberController.text = SharedPrefs.getCarPlateNo().toString();
        mobileNumberController.text = SharedPrefs.getMobileNumber().toString();
        btnActivationStatus = true;
      }
    });
  }

  getBlockNumber() {
    ValidationUtils.showLoaderDialog(context: context);
    widget.onBlockNumber().then((APIResponse response) async {
      if (response.success == true) {
        List<String> items = [];
        for (var element in response.data) {
          items.add(element["block"]);
        }
        await getPersonDetails(items);
      } else {
        ValidationUtils.hideDialog(context: context);
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  getPersonDetails(List<String> blocklist) {
    widget
        .onPersonDetails(
            "+${SharedPrefs.getCountryCode()}${SharedPrefs.getMobileNumber().toString()}")
        .then((APIResponse response) {
      debugPrint(response.data.toString());
      if (response.success == true) {
        if (response.data != null) {
          SharedPrefs.setActiveVisitor("notnull");
          SharedPrefs.setName(response.data['name'].toString());
          SharedPrefs.setId(response.data['nric'].toString());
          SharedPrefs.setCompany(response.data['company'].toString());
          SharedPrefs.setMobileNumber(response.data['mobile'].toString());
          SharedPrefs.setBlockNumber(response.data['visiting_unit']
              .split(",")
              .elementAt(0)
              .toString());
          SharedPrefs.setUnit(response.data['visiting_unit']
              .split(",")
              .elementAt(1)
              .toString());
        } else {
          SharedPrefs.setActiveVisitor("null");
        }
        SharedPrefs.setCarPlateNo(carPlateNumberController.text.trim());
        ValidationUtils.hideDialog(context: context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlockNumberScreen(
                    list: blocklist,
                  )),
        );
      } else {
        ValidationUtils.hideDialog(context: context);
        ValidationUtils.showSnackBar(
            context, "please select sg 65 country code");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;
    return OrientationBuilder(builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;

      return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 50.0),
            child: ReusableAppbar(),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _carPlateKey,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          ReusableString.carPlate,
                          style: GoogleFonts.sora(
                              fontWeight: FontWeight.w500, fontSize: 24.sp),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          ReusableString.editmessage,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sora(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.sp,
                              color: const Color(0xffAAAAAA)),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            ReusableString.plateNumber,
                            style: TextStyle(
                                fontSize: 12.0.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                        ReusableTextFormField(
                          contentPadding: EdgeInsets.all(8.0.sp),
                          obscureText: false,
                          textcapitalization: TextCapitalization.characters,
                          onchange: (v) {
                            if (carPlateNumberController.text != '' &&
                                mobileNumberController.text != '') {
                              setState(() {
                                btnActivationStatus = true;
                              });
                            } else {
                              setState(() {
                                btnActivationStatus = false;
                              });
                            }
                          },
                          controller: carPlateNumberController,
                          margin: const EdgeInsets.only(top: 12, bottom: 4.0),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(ReusableString.mobileNumber,
                              style: CommonStyle.font12SpWeight400),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        SizedBox(
                          height: isPortrait ? mheight * 0.07 : mwidth * 0.08,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CountryCodePickerWidget(),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 40.h,
                                  child: ReusableTextFormField(
                                      textcapitalization:
                                          TextCapitalization.none,
                                      contentPadding: EdgeInsets.all(isPortrait
                                          ? mheight * 0.02
                                          : mwidth * 0.028),
                                      obscureText: false,
                                      onchange: (v) {
                                        if (mobileNumberController.text != '' &&
                                            carPlateNumberController.text !=
                                                '') {
                                          setState(() {
                                            btnActivationStatus = true;
                                          });
                                        } else {
                                          setState(() {
                                            btnActivationStatus = false;
                                          });
                                        }
                                      },
                                      suffixstring: '*',
                                      suffixstyle: const TextStyle(
                                          color: Color(0xffFF003D)),
                                      controller: mobileNumberController,
                                      keyboardtype: TextInputType.phone,
                                      validation: ((value) {
                                        if (value == null || value.isEmpty) {
                                          return ReusableString
                                              .fieldEmptyErrorMsg;
                                        } else {
                                          return null;
                                        }
                                      })),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mheight * 0.1,
                        ),
                        !isPortrait ? continueButton() : SizedBox(),
                        SizedBox(
                          height: 20.h,
                        ),
                      ]),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: isPortrait ? continueButton() : SizedBox());
    });
  }

  Widget continueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: ReusableButton(
        buttonColor: btnActivationStatus
            ? const Color(0xffFF003D)
            : const Color(0xFFAEAEAE),
        buttonName: ReusableString.continuee,
        onPressed: () {
          if (btnActivationStatus) {
            SharedPrefs.setMobileNumber(mobileNumberController.text);
            getBlockNumber();
          }
        },
      ),
    );
  }
}
