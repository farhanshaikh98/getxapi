import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gatekeeper/constant/urls.dart';
import 'api_manager.dart';

class APIService {
  static final APIService _singleton = APIService._internal();

  factory APIService() {
    return _singleton;
  }

  APIService._internal();

  // User Login function
  static Future<APIResponse> login(String userName, String pwd) async {
    final APIResponse resp = await APIManager.postResponse(
        Url.loginEndpointsAPI,
        jsonEncode(<String, String>{
          'username': userName.trim(),
          'password': pwd.trim(),
        }));
    return resp;
  }

  // Get Latest Car
  static Future<APIResponse> getLatestCar() async {
    final APIResponse resp = await APIManager.getResponse(Url.getLatestCarAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // user logout function
  static Future<APIResponse> logout() async {
    final APIResponse resp =
        await APIManager.postResponse(Url.logoutEndpointAPI, null);
    debugPrint(resp.data.toString());
    return resp;
  }

  // check connection with backend function
  static Future<APIResponse> checkConnection() async {
    final APIResponse resp =
        await APIManager.getResponse(Url.checkConnectionAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // get worksite name function
  static Future<APIResponse> getWorkSiteName() async {
    final APIResponse resp =
        await APIManager.getResponse(Url.getWorksiteNameAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // get block number function
  static Future<APIResponse> getBlocNumber() async {
    final APIResponse resp =
        await APIManager.getResponse(Url.getBlockNumberAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // get Activate Visitors function
  static Future<APIResponse> getActivateVisitors() async {
    final APIResponse resp =
        await APIManager.getResponse(Url.getActiveVisitorsAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // get mobile slip format function
  static Future<APIResponse> getMobileSlipPrintFormat() async {
    final APIResponse resp =
        await APIManager.getResponse(Url.getMobilePrintVisitorSlipAPI);
    debugPrint(resp.data.toString());
    return resp;
  }

  // get manual car input function
  static Future<APIResponse> getManualCarInput(String carPlate) async {
    final APIResponse resp = await APIManager.multipartResponse(
        Url.manualInputNewCarAPI, <String, String>{
      'car_plate': carPlate,
    });
    return resp;
  }

  // get manual car input function
  static Future<APIResponse> getPersonDetails(
      String mobilenumberwithcountry) async {
    final APIResponse resp = await APIManager.multipartResponse(
        Url.getPersonDetails, <String, String>{
      'mobile': mobilenumberwithcountry,
    });
    return resp;
  }

  // get mobile number
  static Future<APIResponse> getMobileNumber(String carPlate) async {
    final APIResponse resp = await APIManager.multipartResponse(
        Url.getMobileNumber, <String, String>{
      'car_plate': carPlate,
    });
    return resp;
  }

  // sign out visitor function
  static Future<APIResponse> checkoutVisitor(String id) async {
    final APIResponse resp = await APIManager.multipartResponse(
        Url.checkOutVisitor, <String, String>{
      'id': id,
    });
    return resp;
  }

  // forgot password function
  static Future<APIResponse> passwordRest(String userName) async {
    final APIResponse resp =
        await APIManager.multipartResponse(Url.passwordReset, <String, String>{
      'username': userName,
    });
    return resp;
  }

  // get fetch car function
  static Future<APIResponse> fetchCar(String carPlate) async {
    final APIResponse resp =
        await APIManager.multipartResponse(Url.fetchCarAPI, <String, String>{
      'car_plate': carPlate,
    });
    return resp;
  }

  // get manual car input function
  static Future<APIResponse> getSubmitCarDetailMobile(dynamic params) async {
    final APIResponse resp = await APIManager.multipartResponse(
        Url.submitCarDetailMobileAPI, <String, String>{
      'car_plate': params['car_plate'],
      'nric': params['nric'],
      'name': params['name'],
      'blk': params['blk'],
      'unit': params['unit'],
      'company': params['company'],
      'mobile': params['mobile'],
      'entry_pass': params['entry_pass'],
      'purpose': params['purpose'],
      'remarks': params['remarks'],
      'time': params['time'],
    });
    return resp;
  }
}
