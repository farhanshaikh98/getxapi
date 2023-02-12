import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/constant/styles.dart';
import 'package:gatekeeper/screens/blocknumber/block_number.dart';
import 'package:gatekeeper/screens/mynumber/widgets/country_code_picker_widget.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../../components/reusable_appbar.dart';
import '../../components/reusable_button.dart';
import '../../components/reusable_textformfield.dart';
import '../../constant/strings.dart';
import '../../services/api_manager.dart';
import '../../services/user_service.dart';
import '../../utils/validations.dart';

class MyNumberScreen extends StatefulWidget {
  const MyNumberScreen({super.key});

  Future<APIResponse> onBlockNumber() async {
    return await APIService.getBlocNumber();
  }

  Future<APIResponse> onPersonDetails(String mobilenumberwithcountry) async {
    return await APIService.getPersonDetails(mobilenumberwithcountry);
  }

  @override
  State<MyNumberScreen> createState() => _MyNumberScreenState();
}

class _MyNumberScreenState extends State<MyNumberScreen> {
  final _myNumberKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  bool btnActivationStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMobileInputData();
  }

  getMobileInputData() {
    setState(() {
      if (SharedPrefs.getActiveVisitor() == 'notnull' &&
          SharedPrefs.getMobileNumber().toString().isNotEmpty) {
        debugPrint(SharedPrefs.getActiveVisitor().toString());
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
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50.0),
        child: ReusableAppbar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _myNumberKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30.h,
              ),
              Text(ReusableString.myNumber,
                  style: CommonStyle.font24SpWeight500),
              SizedBox(
                height: 25.h,
              ),
              Text(ReusableString.mobileNumber,
                  style: CommonStyle.font12SpWeight400),
              SizedBox(
                height: 12.h,
              ),
              Row(
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
                          contentPadding: EdgeInsets.all(8.0.sp),
                          textcapitalization: TextCapitalization.none,
                          obscureText: false,
                          onchange: (v) {
                            if (mobileNumberController.text != '') {
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
                          suffixstyle:
                              const TextStyle(color: Color(0xffFF003D)),
                          controller: mobileNumberController,
                          keyboardtype: TextInputType.phone,
                          validation: ((value) {
                            if (value == null || value.isEmpty) {
                              return ReusableString.fieldEmptyErrorMsg;
                            } else {
                              return null;
                            }
                          })),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
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
      ),
    );
  }
}
