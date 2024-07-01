import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:weather/ui/provider.dart';
import 'dependancy_inject.dart';
import 'ui/get_started.dart';

void main(){

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>myProvider()),
      ],child: const GetMaterialApp(
        title: "Weather App",
        debugShowCheckedModeBanner: false,
        home: GetStarted(),
      ),
      ),
  );
  DependencyInjection.init();

}




