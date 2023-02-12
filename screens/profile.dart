import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/utils/preference.dart';
import '../components/reusable_button.dart';
import '../components/reusable_container.dart';
import '../constant/app_asset.dart';
import '../constant/strings.dart';
import '../constant/styles.dart';
import '../model/get_activevisitors.dart';
import '../model/get_mobile_print_visitor_slip.dart';
import '../services/api_manager.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/validations.dart';
import 'purpose/purpose_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatefulWidget {
   ProfileScreen(
      {super.key, this.getActiveVisitorsItem, this.navigateScreenStatus});

  GetActiveVisitorItem? getActiveVisitorsItem;
  bool? navigateScreenStatus;

  Future<APIResponse> onPrintVisitorSlip() async {
    return await APIService.getMobileSlipPrintFormat();
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late GetMobilePrintVisitorSlip printVisitorContent =
  GetMobilePrintVisitorSlip();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printVisitorSlip();
  }

  printVisitorSlip() {
    widget.onPrintVisitorSlip().then((APIResponse response) async {
      if (response.success == true) {
        printVisitorContent = GetMobilePrintVisitorSlip.fromJson(response.data);
        setState(() {});
      } else {
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  String getInitials(String string) => string.isNotEmpty
      ? string.trim().split(RegExp(' +')).map((s) => s[0]).join()
      : '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2A70FF),
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: widget.navigateScreenStatus ?? true
            ? IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          splashRadius: 20,
          icon: SvgPicture.asset(
            AppAsset.arrowbackicon,
            height: MediaQuery.of(context).size.height*0.03,
            width: MediaQuery.of(context).size.width*0.03,
            color: Colors.white,
          ),
        )
            : const SizedBox(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PurposeScreen()));
            },
            splashRadius: 20,
            icon: SvgPicture.asset(
              AppAsset.homeicon,
              color: Colors.white,
              height: MediaQuery.of(context).size.height*0.03,
              width: MediaQuery.of(context).size.width*0.03,
            ),
          ),
          SizedBox(
            width: 6.w,
          ),
        ],
        titleSpacing: 0.0,
        title: Text(
          ReusableString.profile,
          style: CommonStyle.font16SpWeight500white,
        ),
      ),
      body: Stack(
        children: [
          ReusableContainer(
            height: 0.20.sh,
            dBox: const BoxDecoration(
              color: Color(0xff2A70FF),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(children: [
                SizedBox(
                  height: 30.h,
                ),
                ReusableContainer(
                  height: 171.h,
                  width: 307.w,
                  dBox: CommonStyle.profileBoxDeco,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 31.h,
                        backgroundColor: const Color(0xffF2C94C),
                        child: Text(
                          getInitials(widget.getActiveVisitorsItem!.name),
                          style: CommonStyle.font20SpWeight600,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        widget.getActiveVisitorsItem!.name,
                        style: CommonStyle.font16SpWeight700color,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                          widget.getActiveVisitorsItem?.purpose ??
                              SharedPrefs.getPurpose().toString(),
                          style: CommonStyle.font12SpWeight400color)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ReusableContainer(
                  height: 439.h,
                  width: 307.w,
                  dBox: CommonStyle.profileBoxDeco,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25.h,
                          ),
                          Text(ReusableString.carPlateNumber,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.carPlate,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.mobileNumber,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.mobile,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.nRICNumber,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.nRICNumber,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.passNumber,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.passNumber,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.company,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.company,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.inTime,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.inTime,
                              style: CommonStyle.font14SpWeight600black),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(ReusableString.remark,
                              style: CommonStyle.font12SpWeight400profileInfo),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(widget.getActiveVisitorsItem!.remark,
                              style: CommonStyle.font14SpWeight600black),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ReusableButton(
                          buttonColor: const Color(0xffFF003D),
                          buttonName: ReusableString.print,
                          onPressed: () async {
                            await _createPdf(widget.getActiveVisitorsItem!.carPlate, widget.getActiveVisitorsItem!.name, widget.getActiveVisitorsItem!.inTime,widget.getActiveVisitorsItem!.visitingUnit);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ReusableButton(
                          buttonColor: const Color(0xffFF003D),
                          buttonName: ReusableString.done,
                          onPressed: () async {
                            NavigationService(context: context).goPurpose();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
  
  _createPdf(String carplate, String name, String time, String visit) async {
    final doc = pw.Document();
    String bd = printVisitorContent.details.toString();
    String bdch = bd.replaceAll("{{name}}", name);
    bdch = bdch.replaceAll("{{carplate}}", carplate);
    bdch = bdch.replaceAll("{{in_time}}", time);
    bdch = bdch.replaceAll("{{visiting_unit}}", visit);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(150 * 2.834, double.infinity, marginAll: 5 * 2.834 ),
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
              children: [
                pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Container(
                    child: pw.Text(printVisitorContent.header.toString(),style: pw.TextStyle()),
                  ),
                ),
                pw.Container(
                  child: pw.Text(".",style: pw.TextStyle(color: PdfColor(0.99, 0.99, 0.99))),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(
                    child: pw.Text(bdch,style: pw.TextStyle( fontWeight: pw.FontWeight.bold, )),
                  ),
                ),
                pw.Container(
                  child: pw.Text(".",style: pw.TextStyle(color: PdfColor(0.99, 0.99, 0.99))),
                ),
                pw.Container(
                  child: pw.Text(printVisitorContent.body.toString(),style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Container(
                  child: pw.Text(".",style: pw.TextStyle(color: PdfColor(0.99, 0.99, 0.99))),
                ),
                pw.Container(
                    child: pw.Text(printVisitorContent.footer.toString(),style: pw.TextStyle()))
              ]);
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
