import 'dart:developer';
import 'package:getxapi_demo/constants/apiconstants.dart';
import 'package:getxapi_demo/models/postmodel.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<PostModel?> getUsers() async {
    print("object");
    try {
      var url = Uri.parse(ApiConstants.baseurl + ApiConstants.endpoint);
      var response =
          await http.get(url, headers: {'app-id': '6218809df11d1d412af5bac4'});
      print(response.body);
      if (response.statusCode == 200) {
        print('---------');
        print(response.body);
        print('---------');
        PostModel _model = postModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
