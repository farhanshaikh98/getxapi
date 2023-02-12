/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/components/reusable_appbar.dart';
import 'package:gatekeeper/components/reusable_button.dart';
import 'package:gatekeeper/components/reusable_textformfield.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/constant/styles.dart';
import 'package:gatekeeper/services/api_manager.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/validations.dart';

class MyNameIdScreen extends StatefulWidget {
  const MyNameIdScreen({super.key});

  Future<APIResponse> onCarDetail(dynamic params) async {
    return await APIService.getSubmitCarDetailMobile(params);
  }

  @override
  State<MyNameIdScreen> createState() => _MyNameIdScreenState();
}

class _MyNameIdScreenState extends State<MyNameIdScreen> {
  final _myNameId = GlobalKey<FormState>();
  bool btnActivationStatus = false;

  List<String> option = [];

  final _textFieldHints = <String>[];

  TextEditingController nameController = TextEditingController();

  TextEditingController nRICPassportController = TextEditingController();

  TextEditingController passNumberController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPrefToController();

    print("------------");
    print(SharedPrefs.getTestFieldItem());
    print("------------");

    setState(() {});
    _addAutoFillText();

  }

  setPrefToController() {
    if (SharedPrefs.getActiveVisitor().toString() == 'notnull') {
      nameController.text = SharedPrefs.getName().toString();
      nRICPassportController.text = SharedPrefs.getId().toString();
      companyController.text = SharedPrefs.getCompany().toString();
      btnActivationStatus = true;
    }
  }

  submitCarDetail() {
    Map cardinal = <String, String>{
      'car_plate': SharedPrefs.getCarPlateNo().toString(),
      'nric': SharedPrefs.getId().toString(),
      'name': SharedPrefs.getName().toString(),
      'blk': SharedPrefs.getBlockNumber().toString(),
      'unit': SharedPrefs.getUnit().toString(),
      'company': SharedPrefs.getCompany().toString(),
      'mobile': SharedPrefs.getMobileNumber().toString(),
      'entry_pass': SharedPrefs.getPassNumber().toString(),
      'purpose': SharedPrefs.getPurpose().toString(),
      'remarks': SharedPrefs.getRemark().toString(),
      'time': SharedPrefs.getDuration()
          .toString()
          .replaceAll(RegExp(r'[^0-9]'), ''),
    };

    if (btnActivationStatus) {
      ValidationUtils.showLoaderDialog(context: context);
      widget.onCarDetail(cardinal).then((APIResponse response) {
        if (response.success == true) {
          ValidationUtils.hideDialog(context: context);

          // ManualInputCarInDetails.fromJson(response.data);
          NavigationService(context: context).goAgreement();
        } else {
          Navigator.of(context).pop();
          ValidationUtils.hideDialog(context: context);
          ValidationUtils.showSnackBar(context, response.message.toString());
        }
      });
    }
  }

  setPreferenceData() {
    SharedPrefs.setName(nameController.text.toString());
    SharedPrefs.setId(nRICPassportController.text.toString());
    SharedPrefs.setPassNumber(passNumberController.text.toString());
    SharedPrefs.setCompany(companyController.text.toString());
  }

  _addAutoFillText() {
    if (companyController.text.isEmpty) {
      debugPrint('_textFieldController.text is empty');
    } else {
      debugPrint('${companyController.text} added');
      setState(() {
        _textFieldHints.add(companyController.text);

        for (var element in SharedPrefs.getTestFieldItem() ?? []) {
          if (companyController.text != element) _textFieldHints.add(element);
        }
        SharedPrefs.setTestFieldItem(_textFieldHints);
        _textFieldHints.clear();
        companyController.clear();
      });
      debugPrint('_textFieldHints contains:');
      _textFieldHints.sort();
      _textFieldHints.forEach((text) {});
    }
    if (SharedPrefs.getTestFieldItem() == null) {
      SharedPrefs.setTestFieldItem(['']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50.0),
        child: ReusableAppbar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Form(
              key: _myNameId,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(ReusableString.entername,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(
                      textcapitalization: TextCapitalization.none,
                      obscureText: false,
                      controller: nameController,
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.enterid,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(

                      textcapitalization: TextCapitalization.none,
                      obscureText: false,
                      onchange: (v) {
                        if (nRICPassportController.text != '' &&
                            companyController.text != '') {
                          setState(() {
                            btnActivationStatus = true;
                          });
                        } else {
                          setState(() {
                            btnActivationStatus = false;
                          });
                        }
                      },
                      fildlength: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: nRICPassportController,
                      hintext: "Last 4 Digits ID",
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.passnumber,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(
                      textcapitalization: TextCapitalization.none,
                      obscureText: false,
                      controller: passNumberController,
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.company,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      child: RawAutocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return SharedPrefs.getTestFieldItem() ??_textFieldHints.where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          debugPrint('$selection selected');
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          companyController = textEditingController;
                          return ReusableTextFormField(
                            textcapitalization: TextCapitalization.none,
                            obscureText: false,
                            onchange: (v) {
                              if (nRICPassportController.text != '' &&
                                  companyController.text != '') {
                                setState(() {
                                  btnActivationStatus = true;
                                });
                              } else {
                                setState(() {
                                  btnActivationStatus = false;
                                });
                              }
                            },
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            controller: companyController,
                            margin: const EdgeInsets.only(
                              top: 9.0,
                            ),
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Material(
                                elevation: 0.5,
                                child: SizedBox(
                                  height: 170.0,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(1.0),
                                    itemCount: options.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index >= options.length) {
                                        return TextButton(
                                          child: const Text('clear'),
                                          onPressed: () {
                                            companyController.clear();
                                          },
                                        );
                                      }
                                      final String option =
                                      options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableButton(
                        buttonColor: btnActivationStatus
                            ? const Color(0xffFF003D)
                            : const Color(0xFFAEAEAE),
                        buttonName: ReusableString.continuee,
                        onPressed: () async {
                          if (btnActivationStatus) {
                            setPreferenceData();
                            submitCarDetail();
                            _addAutoFillText();
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/components/reusable_appbar.dart';
import 'package:gatekeeper/components/reusable_button.dart';
import 'package:gatekeeper/components/reusable_textformfield.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/constant/styles.dart';
import 'package:gatekeeper/services/api_manager.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/validations.dart';

class MyNameIdScreen extends StatefulWidget {
  const MyNameIdScreen({super.key});
  Future<APIResponse> onCarDetail(dynamic params) async {
    return await APIService.getSubmitCarDetailMobile(params);
  }

  @override
  State<MyNameIdScreen> createState() => _MyNameIdScreenState();
}

class _MyNameIdScreenState extends State<MyNameIdScreen> {
  final _mynameid = GlobalKey<FormState>();
  bool btnActivationStatus = false;
  List<String> option = [];
  final _textFieldHints = <String>[];

  TextEditingController nameController = TextEditingController();

  TextEditingController nricPassportController = TextEditingController();

  TextEditingController passnumberController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPreftocontroller();
    setState(() {});
    _addAutoFillText();
  }

  setPreftocontroller() {
    if (SharedPrefs.getActiveVisitor().toString() == 'notnull') {
      nameController.text = SharedPrefs.getName().toString();
      nricPassportController.text = SharedPrefs.getId().toString();
      companyController.text = SharedPrefs.getCompany().toString();
      btnActivationStatus = true;
    }
  }

  submitCarDetail() {
    Map cardetail = <String, String>{
      'car_plate': SharedPrefs.getCarPlateNo().toString(),
      'nric': SharedPrefs.getId().toString(),
      'name': SharedPrefs.getName().toString(),
      'blk': SharedPrefs.getBlockNumber().toString(),
      'unit': SharedPrefs.getUnit().toString(),
      'company': SharedPrefs.getCompany().toString(),
      'mobile': SharedPrefs.getMobileNumber().toString(),
      'entry_pass': SharedPrefs.getPassNumber().toString(),
      'purpose': SharedPrefs.getPurpose().toString(),
      'remarks': SharedPrefs.getRemark().toString(),
      'time': SharedPrefs.getDuration()
          .toString()
          .replaceAll(RegExp(r'[^0-9]'), ''),
    };

    ValidationUtils.showLoaderDialog(context: context);
    widget.onCarDetail(cardetail).then((APIResponse response) {
      if (response.success == true) {
        ValidationUtils.hideDialog(context: context);

        // ManualInputCarInDetails.fromJson(response.data);
        NavigationService(context: context).goAgreement();
      } else {
        Navigator.of(context).pop();
        ValidationUtils.hideDialog(context: context);
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  setPreferenceData() {
    SharedPrefs.setName(nameController.text.toString());
    SharedPrefs.setId(nricPassportController.text.toString());
    SharedPrefs.setPassNumber(passnumberController.text.toString());
    SharedPrefs.setCompany(companyController.text.toString());
  }

  _addAutoFillText() {
    if (companyController.text.isEmpty) {
      debugPrint('_textFieldController.text is empty');
    } else {
      debugPrint('${companyController.text} added');
      setState(() {
        _textFieldHints.add(companyController.text);

        for (var element in SharedPrefs.getTestFieldItem() ?? []) {
          if (companyController.text != element) _textFieldHints.add(element);
        }
        SharedPrefs.setTestFieldItem(_textFieldHints);
        _textFieldHints.clear();
        companyController.clear();
      });
      debugPrint('_textFieldHints contains:');
      _textFieldHints.sort();
      _textFieldHints.forEach((text) {});
    }
    if (SharedPrefs.getTestFieldItem() == null) {
      SharedPrefs.setTestFieldItem(['']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 50.0),
        child: ReusableAppbar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Form(
              key: _mynameid,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(ReusableString.entername,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(
                      contentPadding: EdgeInsets.all(8.0.sp),
                      obscureText: false,
                      textcapitalization: TextCapitalization.none,
                      controller: nameController,
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.enterid,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(
                      contentPadding: EdgeInsets.all(8.0.sp),
                      obscureText: false,
                      textcapitalization: TextCapitalization.none,
                      fildlength: [
                        LengthLimitingTextInputFormatter(4),
                      ],
                      controller: nricPassportController,
                      hintext: "Last 4 Digits ID",
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.passnumber,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    ReusableTextFormField(
                      contentPadding: EdgeInsets.all(8.0.sp),
                      obscureText: false,
                      textcapitalization: TextCapitalization.none,
                      controller: passnumberController,
                      margin: const EdgeInsets.only(top: 12, bottom: 20),
                    ),
                    Text(ReusableString.company,
                        style: CommonStyle.font12SpWeight400),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1.0),
                      child: RawAutocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == null ||
                              textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return SharedPrefs.getTestFieldItem()!
                              .toList()
                              .where((String option) {
                            return option
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String selection) {
                          debugPrint('$selection selected');
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          companyController = textEditingController;
                          return ReusableTextFormField(
                            contentPadding: EdgeInsets.all(8.0.sp),
                            textcapitalization: TextCapitalization.none,
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              onFieldSubmitted();
                            },
                            obscureText: false,
                            controller: companyController,
                            margin: const EdgeInsets.only(
                              top: 9.0,
                            ),
                          );
                        },
                        optionsViewBuilder: (BuildContext context,
                            AutocompleteOnSelected<String> onSelected,
                            Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: Material(
                                elevation: 0.5,
                                child: SizedBox(
                                  height: 170.0,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(1.0),
                                    itemCount: options.length + 1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index >= options.length) {
                                        return TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            companyController.clear();
                                          },
                                        );
                                      }
                                      String option = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: () {
                                          onSelected(option);
                                        },
                                        child: ListTile(
                                          title: Text(option),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableButton(
                        buttonColor: const Color(0xffFF003D),
                        buttonName: ReusableString.continuee,
                        onPressed: () async {
                          setPreferenceData();
                          submitCarDetail();
                          _addAutoFillText();
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
