import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  Connectivity connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(netStatus);
  }

  netStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
          titleText: SizedBox(
            width: double.maxFinite,
            height: Get.height * 0.954,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 120,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          messageText: const SizedBox(),
          backgroundColor: Colors.black87,
          isDismissible: false,
          duration: const Duration(days: 9999));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}