import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static const _kAccessToken = 'authToken';
  static const _kWorksiteName = 'worksiteName';
  static const _kUserName = 'userName';
  static const _kAgreement = 'agreement';
  static const _kCarPlateNumber = 'car_plate_no';
  static const _kMobileNumber = 'mobile_number';
  static const _kUnitNumber = 'unit_number';
  static const _kRemark = 'remark';
  static const _kBlockNumber = 'blocknumber';
  static const _kDuration = 'duration';
  static const _kPurpose = 'purpose';
  static const _kName = 'name';
  static const _kId = 'id';
  static const _kPassNumber = 'pass_number';
  static const _kCompany = 'company';
  static const _kCarId = 'carid';
  static const _kCountryCode = 'countrycode';
  static const _kActiveVisitor = 'activevisitor';
  static const _kTextFieldIterm = "textfileitem";

  static bool? getBool(String key) => _instance.getBool(key);

  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static String? getString(String key) => _instance.getString(key);

  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  static int? getInt(String key) => _instance.getInt(key);

  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  static Future<bool> setAccessToken(String value) =>
      _instance.setString(_kAccessToken, value);

  static String? getAccessToken() => _instance.getString(_kAccessToken);

  static Future<bool> setUserName(String value) =>
      _instance.setString(_kUserName, value);

  static String? getUserName() => _instance.getString(_kUserName);

  static Future<bool> setMobileNumber(String value) =>
      _instance.setString(_kMobileNumber, value);

  static String? getMobileNumber() => _instance.getString(_kMobileNumber);

  static Future<bool> setAgreement(String value) =>
      _instance.setString(_kAgreement, value);

  static String? getAgreement() => _instance.getString(_kAgreement);

  static Future<bool> setUnit(String value) =>
      _instance.setString(_kUnitNumber, value);

  static String? getUnit() => _instance.getString(_kUnitNumber);

  static Future<bool> setRemark(String value) =>
      _instance.setString(_kRemark, value);

  static String? getRemark() => _instance.getString(_kRemark);

  static Future<bool> setWorkSite(String value) =>
      _instance.setString(_kWorksiteName, value);

  static Future<bool> setCarPlateNo(String value) =>
      _instance.setString(_kCarPlateNumber, value);

  static String? getCarPlateNo() => _instance.getString(_kCarPlateNumber);

  static Future<bool> setBlockNumber(String value) =>
      _instance.setString(_kBlockNumber, value);

  static String? getBlockNumber() => _instance.getString(_kBlockNumber);

  static Future<bool> setDuration(String value) =>
      _instance.setString(_kDuration, value);

  static String? getDuration() => _instance.getString(_kDuration);

  static Future<bool> setName(String value) =>
      _instance.setString(_kName, value);

  static String? getName() => _instance.getString(_kName);

  static Future<bool> setId(String value) => _instance.setString(_kId, value);

  static String? getId() => _instance.getString(_kId);

  static Future<bool> setPassNumber(String value) =>
      _instance.setString(_kPassNumber, value);

  static String? getPassNumber() => _instance.getString(_kPassNumber);

  static Future<bool> setCountryCode(String value) =>
      _instance.setString(_kCountryCode, value);

  static String? getCountryCode() => _instance.getString(_kCountryCode);

  static Future<bool> setCompany(String value) =>
      _instance.setString(_kCompany, value);

  static String? getCompany() => _instance.getString(_kCompany);

  static Future<bool> setPurpose(String value) =>
      _instance.setString(_kPurpose, value);

  static String? getPurpose() => _instance.getString(_kPurpose);

  static Future<bool> setCarId(String value) =>
      _instance.setString(_kCarId, value);

  static String? getCarId() => _instance.getString(_kCarId);

  static Future<bool> setActiveVisitor(String value) =>
      _instance.setString(_kActiveVisitor, value);

  static String? getActiveVisitor() => _instance.getString(_kActiveVisitor);

  static String? getWorkSite() => _instance.getString(_kWorksiteName);

  static Future<bool> remove(String key) => _instance.remove(key);

  static Future<bool> clear() => _instance.clear();

  static setTestFieldItem(List<String> value) =>
      _instance.setStringList(_kTextFieldIterm, value);

  static List<String>? getTestFieldItem() =>
      _instance.getStringList(_kTextFieldIterm);
}
