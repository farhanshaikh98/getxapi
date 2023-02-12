import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/screens/agreement/widgets/checkbox_widget.dart';
import 'package:gatekeeper/screens/profile.dart';
import 'package:gatekeeper/utils/colors.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../../components/reusable_appbar.dart';
import '../../components/reusable_button.dart';
import '../../components/reusable_container.dart';
import '../../constant/strings.dart';
import '../../constant/styles.dart';
import '../../model/get_activevisitors.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => AgreementScreenState();
}

class AgreementScreenState extends State<AgreementScreen> {
  final _scrollController = ScrollController();
  bool btnActivationStatus = false;
  bool isReadMore = false;
  GetActiveVisitorItem setVisitors() {
    return GetActiveVisitorItem(
        name: SharedPrefs.getName().toString(),
        carPlate: SharedPrefs.getCarPlateNo().toString(),
        mobile:
        "+${SharedPrefs.getCountryCode().toString() + SharedPrefs.getMobileNumber().toString()}",
        nRICNumber: SharedPrefs.getId().toString(),
        company: SharedPrefs.getCompany().toString(),
        inTime: SharedPrefs.getDuration().toString(),
        passNumber: SharedPrefs.getPassNumber().toString(),
        purpose: SharedPrefs.getPurpose().toString(),
        remark: SharedPrefs.getRemark().toString(),
        visitingUnit: SharedPrefs.getBlockNumber().toString() + ": " + SharedPrefs.getUnit().toString());
  }

  Widget buildText(String text) {
    final lines = isReadMore ? null : 2;
    return Text(
      text,
      style: CommonStyle.font12SpWeight300,
      maxLines: lines,
      overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.0.sp),
        child: const ReusableAppbar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 30.h,
            ),
            Text(ReusableString.nda, style: CommonStyle.font24SpWeight500),
            SizedBox(
              height: 13.h,
            ),
            ReusableContainer(
              height: 250.h,
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SharedPrefs.getAgreement().toString(),
                        // ReusableString.agreementCase,
                        style: CommonStyle.font13SpWeight300color,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckBoxWidget(
                  onCheck: () {
                    setState(() {
                      btnActivationStatus = !btnActivationStatus;
                    });
                  },
                  selected: btnActivationStatus,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildText(
                          ReusableString.checkTermsAndCondition,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isReadMore = !isReadMore;
                              });
                            },
                            child: Text(
                              (isReadMore ? 'Read Less' : 'Read More'),
                              style: TextStyle(color: CommonColor.primarySplashColor),
                            ))
                      ],
                    ))
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ReusableButton(
                buttonColor: btnActivationStatus
                    ? const Color(0xffFF003D)
                    : const Color(0xFFAEAEAE),
                buttonName: ReusableString.submit,
                onPressed: () {
                  if (btnActivationStatus) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            getActiveVisitorsItem: setVisitors(),
                            navigateScreenStatus: false,
                          )),
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
