import 'package:package_info/package_info.dart';

class AppDetails {
  static late final PackageInfo _packageInfo;

  static Future<PackageInfo> init() async =>
      _packageInfo = await PackageInfo.fromPlatform();

  static String? getAppVersion() => _packageInfo.version;

  static String? getPackageName() => _packageInfo.packageName;

  static String? getAppName() => _packageInfo.appName;

  static String? getBuildNumber() => _packageInfo.buildNumber;
}
