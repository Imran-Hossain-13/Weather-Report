import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController{
  final _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    // _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(ConnectivityResult conResult){
    if(conResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: const Text(
          "Please Connect To The Internet",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14
          ),
        ),
        isDismissible: false,
        backgroundColor: Colors.black,
        duration: const Duration(days: 1),
        icon: const Icon(Icons.wifi_off,color: Colors.white,size: 35,),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.FLOATING,
      );
    }else{
      Get.back();
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}
