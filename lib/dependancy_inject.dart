import 'package:get/get.dart';
import 'package:weather/connection_checker.dart';

class DependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}