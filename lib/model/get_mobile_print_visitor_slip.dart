import 'dart:convert';

GetMobilePrintVisitorSlip getMobilePrintVisitorSlipFromJson(String str) =>
    GetMobilePrintVisitorSlip.fromJson(json.decode(str));

String getMobilePrintVisitorSlipToJson(GetMobilePrintVisitorSlip data) =>
    json.encode(data.toJson());

class GetMobilePrintVisitorSlip {
  GetMobilePrintVisitorSlip({
    this.id,
    this.header,
    this.details,
    this.body,
    this.footer,
    this.worksite,
  });

  int? id;
  String? header;
  String? details;
  String? body;
  String? footer;
  int? worksite;

  factory GetMobilePrintVisitorSlip.fromJson(Map<String, dynamic> json) =>
      GetMobilePrintVisitorSlip(
        id: json["id"],
        header: json["header"],
        details: json["details"],
        body: json["body"],
        footer: json["footer"],
        worksite: json["worksite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "header": header,
        "details": details,
        "body": body,
        "footer": footer,
        "worksite": worksite,
      };
}
