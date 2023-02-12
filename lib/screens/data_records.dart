import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gatekeeper/model/visitors_model.dart';
import 'package:gatekeeper/screens/profile.dart';
import 'package:gatekeeper/services/api_manager.dart';
import '../components/reusable_button.dart';
import '../constant/app_asset.dart';
import '../constant/strings.dart';
import '../constant/styles.dart';
import '../model/get_activevisitors.dart';
import '../model/get_mobile_print_visitor_slip.dart';
import '../services/navigation_service.dart';
import '../services/user_service.dart';
import '../utils/validations.dart';
import 'purpose/purpose_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DataRecordsScreen extends StatefulWidget {
   DataRecordsScreen({super.key, this.getActiveVisitors});

  Future<APIResponse> onCheckout(String id) async {
    return await APIService.checkoutVisitor(id);
  }

   Future<APIResponse> onPrintVisitorSlip() async {
     return await APIService.getMobileSlipPrintFormat();
   }


   List<GetActiveVisitors>? getActiveVisitors = [];

  @override
  State<DataRecordsScreen> createState() => _DataRecordsScreenState();
}

class _DataRecordsScreenState extends State<DataRecordsScreen> {
  TextEditingController searchController = TextEditingController();
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];
  List<GetActiveVisitors> _searchGetActiveVisitors = [];

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

  checkoutHandle(GetActiveVisitors item, int index) async {
    ValidationUtils.showLoaderDialog(context: context);
    widget.onCheckout(item.id.toString()).then((APIResponse response) {
      if (response.success == true) {
        ValidationUtils.hideDialog(context: context);
        if (_searchGetActiveVisitors.isNotEmpty) {
          _searchGetActiveVisitors.remove(item);
          widget.getActiveVisitors!.remove(item);
        } else {
          widget.getActiveVisitors!.remove(item);
        }
        setState(() {});
        ValidationUtils.showSnackBar(context, response.message.toString());
      } else {
        ValidationUtils.hideDialog(context: context);
        ValidationUtils.showSnackBar(context, response.message.toString());
      }
    });
  }

  GetActiveVisitorItem setVisitors(GetActiveVisitors getActiveVisitorsitem) {
    return GetActiveVisitorItem(
        name: getActiveVisitorsitem.person?.name ?? "",
        carPlate: getActiveVisitorsitem.car?.carPlate ?? "",
        mobile: getActiveVisitorsitem.person?.mobile ?? "",
        nRICNumber: getActiveVisitorsitem.person?.nric ?? '',
        company: getActiveVisitorsitem.person?.company ?? "",
        inTime: getActiveVisitorsitem.inTime ?? "",
        passNumber: getActiveVisitorsitem.entryPass ?? "",
        purpose: getActiveVisitorsitem.purpose ?? "",
        visitingUnit: getActiveVisitorsitem.visitingUnit ?? "",
        remark: 'NA');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: !_searchBoolean
            ? [
                IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 25.0,
                      color: Colors.black,
                    ),
                    splashRadius: 20,
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                        _searchIndexList = [];
                      });
                    }),
                SizedBox(
                  width: 10.w,
                ),
                IconButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PurposeScreen()));
                  }),
                  splashRadius: 20,
                  icon: SvgPicture.asset(
                    AppAsset.homeicon,
                    height: MediaQuery.of(context).size.height*0.03,
                    width: MediaQuery.of(context).size.width*0.03,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ]
            : [
                IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 25.0,
                      color: Colors.black,
                    ),
                    splashRadius: 20,
                    onPressed: () {
                      setState(() {
                        _searchGetActiveVisitors = [];
                        searchController.text = '';
                        _searchBoolean = false;
                      });
                    })
              ],
        title: !_searchBoolean
            ? Row(
                children: [
                  IconButton(
                    onPressed: (() {
                      // NavigationService(context: context).toRoot();
                      Navigator.pop(context);
                    }),
                    splashRadius: 20.0.sp,
                    icon: SvgPicture.asset(
                      AppAsset.arrowbackicon,
                      height: MediaQuery.of(context).size.height*0.03,
                      width: MediaQuery.of(context).size.width*0.03,
                      // color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Text(ReusableString.dataRecords,
                      style: CommonStyle.font16SpWeight500colorBlack),
                ],
              )
            : _searchTextField(),
      ),
      body: widget.getActiveVisitors!.isNotEmpty
          ? _defaultListView()
          : const Center(
              child: Text(ReusableString.noActiveVisitors),
            ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: searchController,
      onChanged: (String s) {
        setState(() {
          _searchGetActiveVisitors = [];
          for (int i = 0; i < widget.getActiveVisitors!.length; i++) {
            if (widget.getActiveVisitors![i].person!.name!
                .toString()
                .toLowerCase()
                .contains(s.toLowerCase())) {
              _searchGetActiveVisitors.add(widget.getActiveVisitors![i]);
            }
          }
          if (_searchGetActiveVisitors.toString().isEmpty) {
            _searchGetActiveVisitors = [];
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _defaultListView() {
    return Column(
      children: [
        searchController.text.isNotEmpty
            ? _searchGetActiveVisitors.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _searchGetActiveVisitors.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                      getActiveVisitorsItem: setVisitors(
                                          _searchGetActiveVisitors[index]))),
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.sp,
                                      backgroundColor:
                                          _searchGetActiveVisitors[index].color,
                                      child: Text(
                                        getInitials(_searchGetActiveVisitors
                                                .isNotEmpty
                                            ? _searchGetActiveVisitors[index]
                                                .person!
                                                .name
                                                .toString()
                                            : ""),
                                        style: CommonStyle.font12SpWeight600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              _searchGetActiveVisitors[index]
                                                  .person!
                                                  .name
                                                  .toString(),
                                              style:
                                                  CommonStyle.font14SpWeight700,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        Text(
                                          "Pass Number:${_searchGetActiveVisitors[index].entryPass}",
                                          style: CommonStyle.font12SpWeight400,
                                        ),
                                        Text(
                                          "Mobile no.${_searchGetActiveVisitors[index].person!.mobile}",
                                          style: CommonStyle.font12SpWeight400,
                                        ),
                                        Text(
                                            "In Time: ${_searchGetActiveVisitors[index].inTime}",
                                            style:
                                                CommonStyle.font12SpWeight400),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: (() async{
                                        await _createPdf("${_searchGetActiveVisitors[index].car!.carPlate}","${_searchGetActiveVisitors[index].person!.name}", "${_searchGetActiveVisitors[index].inTime}", "${_searchGetActiveVisitors[index].visitingUnit}");
                                      }),
                                      child: SvgPicture.asset(
                                        AppAsset.printicon,
                                        width: 30.sp,
                                        // color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    InkWell(
                                      onTap: (() {
                                        setState(() {
                                          checkoutHandle(
                                              _searchGetActiveVisitors[index],
                                              index);
                                        });
                                      }),
                                      child: SvgPicture.asset(
                                        AppAsset.signouticon,
                                        width: 30.sp,
                                        // color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 13.0, bottom: 16.0),
                                width: double.infinity,
                                height: 1.h,
                                color: const Color(0xffE0E0E0),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                    child: Text("No Search Result Found!"),
                  ))
            : Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: widget.getActiveVisitors!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                    getActiveVisitorsItem: setVisitors(
                                        widget.getActiveVisitors![index]),
                                    navigateScreenStatus: true,
                                  )),
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 20.sp,
                                  backgroundColor:
                                      widget.getActiveVisitors![index].color,
                                  child: Text(
                                    getInitials(
                                        widget.getActiveVisitors!.isNotEmpty
                                            ? widget.getActiveVisitors![index]
                                                .person!.name
                                                .toString()
                                            : ""),
                                    style: CommonStyle.font12SpWeight600,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.h,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.getActiveVisitors![index].person!
                                          .name
                                          .toString(),
                                      style: CommonStyle.font14SpWeight700,
                                    ),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(
                                      "Pass Number: ${widget.getActiveVisitors![index].entryPass}",
                                      style: CommonStyle.font12SpWeight400,
                                    ),
                                    Text(
                                      "Mobile no.${widget.getActiveVisitors![index].person!.mobile}",
                                      style: CommonStyle.font12SpWeight400,
                                    ),
                                    Text(
                                        "In Time: ${widget.getActiveVisitors![index].inTime}",
                                        style: CommonStyle.font12SpWeight400),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: (() async{
                                    await _createPdf("${widget.getActiveVisitors![index].car!.carPlate}","${widget.getActiveVisitors![index].person!.name}","${widget.getActiveVisitors![index].inTime}","${widget.getActiveVisitors![index].visitingUnit}");
                                  }),
                                  child: SvgPicture.asset(
                                    AppAsset.printicon,
                                    width: 30.sp,
                                    // color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      checkoutHandle(
                                          widget.getActiveVisitors![index],
                                          index);

                                      //removeOne(_colors[index].value);
                                    });
                                  }),
                                  child: SvgPicture.asset(
                                    AppAsset.signouticon,
                                    width: 30.sp,
                                    // color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 13.0, bottom: 16.0),
                            width: double.infinity,
                            height: 1.h,
                            color: const Color(0xffE0E0E0),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
        _searchBoolean
            ? Container()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ReusableButton(
                  buttonColor: const Color(0xffFF003D),
                  buttonName: ReusableString.continuee,
                  onPressed: () async {
                    NavigationService(context: context).goLogout();
                  },
                ),
              ),
        SizedBox(
          height: 20.h,
        ),
      ],
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
        pageFormat: PdfPageFormat(150 * 2.834, double.infinity, marginAll: 5 * 2.834),
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
