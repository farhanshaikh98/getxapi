import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/postmodel.dart';
import '../services/apiservices.dart';

class HomeController extends GetxController {
  PostModel? result;
  var isDataLoading = true.obs;

  @override
  void onInit() {
    // onActiveVisitors();

    super.onInit();
  }

  onActiveVisitors() async {
    isDataLoading(true);
    result = await ApiServices.getUsers();
    isDataLoading(false);
  }
}
