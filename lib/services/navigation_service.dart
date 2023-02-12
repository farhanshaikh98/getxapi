import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/preference.dart';

class GateKeeperPages {
  static const String purpose = '/purpose';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String carPlate = '/carPlate';
  static const String myNumber = '/myNumber';
  static const String logout = '/logout';
  static const String profile = '/profile';
  static const String agreement = '/agreement';
  static const String blocNumber = '/blocNumber';
  static const String dataRecord = '/dataRecord';
  static const String myNameId = '/myNameId';
  static const String forgotPassword = '/forgotPassword';
}

class NavigationService {
  NavigationService({required this.context});

  final BuildContext context;

  void toRoot() {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    Navigator.pop(context);
  }

  void logout() {
    SharedPrefs.clear();
    toRoot();
    goToPage(GateKeeperPages.login);
  }

  void goPurpose() {
    toRoot();
    goToPage(GateKeeperPages.purpose);
  }

  void forgotPassword() {
    goToPage(GateKeeperPages.forgotPassword);
  }

  void goProfile() {
    goToPage(GateKeeperPages.profile);
  }

  void gocarPlate() {
    goToPage(GateKeeperPages.carPlate);
  }

  void goDataRecord() {
    goToPage(GateKeeperPages.dataRecord);
  }

  void goLogout() {
    goToPage(GateKeeperPages.logout);
  }

  void goMyNumber() {
    goToPage(GateKeeperPages.myNumber);
  }

  void goMyNameId() {
    goToPage(GateKeeperPages.myNameId);
  }

  void goAgreement() {
    goToPage(GateKeeperPages.agreement);
  }

  void goBlockNumber(List<String>? blockNumber) {
    goToPage(GateKeeperPages.blocNumber, blockNumber: blockNumber);
  }

  void goLogin() {
    toRoot();
    goToPage(GateKeeperPages.login);
  }

  void goToPage(String page, {List<String>? blockNumber}) {
    Navigator.pushNamed(context, page, arguments: blockNumber);
  }

  void goToPageAndReplace(String page) {
    Navigator.pushReplacementNamed(context, page);
  }
}
