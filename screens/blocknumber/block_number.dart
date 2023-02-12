import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/screens/blocknumber/widgets/dropdown_widget.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../../components/reusable_appbar.dart';
import '../../components/reusable_button.dart';
import '../../components/reusable_container.dart';
import '../../components/reusable_textformfield.dart';
import '../../constant/strings.dart';
import '../../constant/styles.dart';
import '../../services/api_manager.dart';
import '../../services/navigation_service.dart';
import '../../services/user_service.dart';
import '../../utils/colors.dart';
import '../../utils/validations.dart';

class BlockNumberScreen extends StatefulWidget {
  const BlockNumberScreen({super.key, this.list});

  final List<String>? list;

  Future<APIResponse> onCarDetail(dynamic params) async {
    return await APIService.getSubmitCarDetailMobile(params);
  }

  @override
  State<BlockNumberScreen> createState() => _BlockNumberScreenState();
}

class _BlockNumberScreenState extends State<BlockNumberScreen> {
  final _blockId = GlobalKey<FormState>();
  bool buttonState = false;
  List<String> option = [];
  final _textFieldHints = <String>[];
  TextEditingController unitNumberController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController nricPassportController = TextEditingController();

  TextEditingController passnumberController = TextEditingController();

  TextEditingController companyController = TextEditingController();

  List<String> durationItemsList = [
    '15 minutes',
    '30 minutes',
    '1 hours',
    '2 hours',
    '3 hours',
    '5 hours',
    '7 hours',
    '10 hours',
    '12 hours',
  ];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setapiPreferenceData();
    setState(() {});
    _addAutoFillText();
  }

  setapiPreferenceData() {
    if (SharedPrefs.getActiveVisitor().toString() == 'notnull') {
      unitNumberController.text = SharedPrefs.getUnit().toString();
      SharedPrefs.setDuration(durationItemsList[0]);
      nameController.text = SharedPrefs.getName().toString();
      nricPassportController.text = SharedPrefs.getId().toString();
    } else {
      SharedPrefs.setBlockNumber(widget.list![0]);
      SharedPrefs.setDuration(durationItemsList[0]);
    }
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
    SharedPrefs.setUnit(unitNumberController.text.toString());
    SharedPrefs.setRemark(remarkController.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    var mheight = MediaQuery.of(context).size.height;
    var mwidth = MediaQuery.of(context).size.width;

    return OrientationBuilder(builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.0.sp),
          child: const ReusableAppbar(),
        ),
        backgroundColor: CommonColor.backgroundWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _blockId,
              child: ReusableContainer(
                margin: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.h,
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
                              return option.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
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
                                        String option =
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
                        height: 13.h,
                      ),
                      Row(
                        children: [
                          Text(ReusableString.blocknumber,
                              style: CommonStyle.font12SpWeight400),
                          SizedBox(
                            width: isPortrait ? mheight * 0.05 : mwidth * 0.20,
                          ),
                          Text(ReusableString.unitnumber,
                              style: CommonStyle.font12SpWeight400),
                        ],
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      SizedBox(
                        // color: Colors.red,
                        // height: 50,
                        height: isPortrait ? mheight * 0.07 : mwidth * 0.08,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropdownWidget(
                              itemList: widget.list ?? [""],
                              checkPurpose: "blocknumber",
                              dropdbuttonheight: mheight,
                              dropdbuttonwidth:
                                  MediaQuery.of(context).size.width * 0.3,
                              dropdownwidth:
                                  MediaQuery.of(context).size.width * 0.3,
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Expanded(
                              child: ReusableTextFormField(
                                textcapitalization: TextCapitalization.none,
                                contentPadding: EdgeInsets.all(isPortrait
                                    ? mheight * 0.02
                                    : mwidth * 0.028),
                                obscureText: false,
                                onchange: (v) {
                                  if (unitNumberController.text != '' &&
                                      remarkController.text != '') {
                                    setState(() {
                                      buttonState = true;
                                    });
                                  } else {
                                    setState(() {
                                      buttonState = false;
                                    });
                                  }
                                },
                                controller: unitNumberController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(ReusableString.duration,
                          style: CommonStyle.font12SpWeight400),
                      SizedBox(
                        height: 13.h,
                      ),
                      DropdownWidget(
                        itemList: durationItemsList,
                        checkPurpose: "duration",
                        dropdbuttonheight: 40.h,
                        dropdbuttonwidth: double.infinity,
                        dropdownwidth: MediaQuery.of(context).size.width - 50,
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(ReusableString.remarks,
                          style: CommonStyle.font12SpWeight400),
                      SizedBox(
                        height: 3.h,
                      ),
                      ReusableTextFormField(
                        contentPadding: EdgeInsets.all(8.0.sp),
                        textcapitalization: TextCapitalization.none,
                        obscureText: false,
                        onchange: (v) {
                          if (unitNumberController.text != '' &&
                              remarkController.text != '') {
                            setState(() {
                              buttonState = true;
                            });
                          } else {
                            setState(() {
                              buttonState = false;
                            });
                          }
                        },
                        controller: remarkController,
                        margin: const EdgeInsets.only(top: 12, bottom: 20),
                        maxline: 4,
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ReusableButton(
                            buttonColor: const Color(0xffFF003D),
                            buttonName: ReusableString.continuee,
                            onPressed: () {
                              setPreferenceData();
                              submitCarDetail();
                              _addAutoFillText();
                            }),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
