import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'common_utils.dart';

class NetworkCheck {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    }
    return false;
  }

  static Future<bool> isOnline({bool showError = true}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    printFunction("connectivityResult", connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    }
    if (showError) showToast("Please Check Internet Connection".tr, isError: true, isLong: true);
    return false;
  }

  dynamic checkInternet(Function func) {
    check().then((internet) {
      if (internet) {
        func(true);
      } else {
        func(false);
      }
    });
  }
}
