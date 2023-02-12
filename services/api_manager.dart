import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatekeeper/constant/strings.dart';
import 'package:gatekeeper/constant/urls.dart';
import 'package:gatekeeper/utils/preference.dart';
import 'package:http/http.dart';

class APIResponse {
  APIResponse(Map<String, dynamic> value) {
    success = value['status'] as bool;
    message = value['message:'] as String;
    data = value['data'];
  }

  bool? success;
  String? message;
  dynamic data;
}

class APIManager {
  static Future<APIResponse> postResponse(String path, dynamic params) async {
    if (await isNetworkReachable()) {
      final Response response = await post(
        Uri.parse(Url.baseUrl + path),
        body: params,
        headers: path.contains(Url.loginEndpointsAPI)
            ? getLoginHeader()
            : getHeader(),
      );
      debugPrint('api - ${Url.baseUrl + path}');
      debugPrint('params - $params');
      debugPrint(
          'header - ${path.contains(Url.loginEndpointsAPI) ? getLoginHeader() : getHeader()}');
      debugPrint('response - ${response.body}');
      return formatResponse(response: response, apiType: true);
    } else {
      return APIResponse(ReusableString.networkErrorRes);
    }
  }

  static Future<APIResponse> multipartResponse(
      String path, dynamic params) async {
    if (await isNetworkReachable()) {
      var request = MultipartRequest('POST', Uri.parse(Url.baseUrl + path));
      request.fields.addAll(params);
      request.headers.addAll(getHeader());
      StreamedResponse response = await request.send();
      final String resBody = await response.stream.bytesToString();
      debugPrint('api - ${Url.baseUrl + path}');
      debugPrint('params - $params');
      debugPrint('header - ${getHeader()}');
      debugPrint('response - $resBody');
      return formatResponse(
          response: Response(resBody, response.statusCode), apiType: false);
    } else {
      return APIResponse(ReusableString.networkErrorRes);
    }
  }

  static Future<APIResponse> patchResponse(String path, dynamic params) async {
    if (await isNetworkReachable()) {
      final Response response = await patch(
        Uri.parse(Url.baseUrl + path),
        headers: getHeader(),
        body: params,
      );
      return formatResponse(response: response, apiType: false);
    } else {
      return APIResponse(ReusableString.networkErrorRes);
    }
  }

  static Future<APIResponse> deleteResponse(String path, dynamic params) async {
    if (await isNetworkReachable()) {
      final Response response = await delete(
        Uri.parse(Url.baseUrl + path),
        headers: getHeader(),
        body: params,
      );
      return formatResponse(response: response, apiType: false);
    } else {
      return APIResponse(ReusableString.networkErrorRes);
    }
  }

  static Future<APIResponse> getResponse(String path) async {
    if (await isNetworkReachable()) {
      final Response response = await get(
        Uri.parse(Url.baseUrl + path),
        headers: getHeader(),
      );
      debugPrint('api - ${Url.baseUrl + path}');
      debugPrint('response - ${response.body}');
      return formatResponse(response: response, apiType: false);
    } else {
      return APIResponse(ReusableString.networkErrorRes);
    }
  }

  static Future<bool> isNetworkReachable() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('connected');
        return true;
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
      Fluttertoast.showToast(
        msg: ReusableString.connectionMsg,
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16.0,
      );
      return false;
    }
    return false;
  }

  static Map<String, String> getHeader() {
    String? authToken = SharedPrefs.getAccessToken();
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authToken != null ? 'Token $authToken' : 'None',
    };
  }

  static Map<String, String> getLoginHeader() {
    String? authToken = SharedPrefs.getAccessToken();
    debugPrint('authToken - $authToken');
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authToken != null ? 'Token $authToken' : 'None',
    };
  }

  static APIResponse formatResponse(
      {required Response response, required bool apiType}) {
    switch (response.statusCode) {
      case 200:
        if (apiType) {
          return APIResponse({
            'status': true,
            'message:': 'successful',
            'data': jsonDecode(response.body)
          });
        }
        return APIResponse(jsonDecode(response.body) as Map<String, dynamic>);
      case 400:
        return APIResponse(<String, dynamic>{
          'status': false,
          'message:': '** 400: Bad Request Exception **${response.body}'
        });
      case 401:
      case 403:
        return APIResponse(<String, dynamic>{
          'status': false,
          'message:': '401/403: Unauthorized Exception ${response.body}'
        });
      case 500:
      default:
        return APIResponse(<String, dynamic>{
          'status': false,
          'message:':
              '** Fetch Data Exception - Error occurred while Communication with Server with StatusCode: ${response.statusCode}'
        });
    }
  }
}
