import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/api.dart';
import 'package:intl/intl.dart';
import '../models/city.dart';
import '../widgets/WeatherItem.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  

  WeatherApiClient cl = WeatherApiClient();
  SearchCity cl2 = SearchCity();
  Weather data = Weather();
  Weather data2 = Weather();

  List oldSelectedCities = City.getTrueCitie();
  int cityIndex = 0;
  List<String> selectedCities = [];
  int forecastDayNumber = 0;

  Map<String,dynamic> fixedDateData = {};
  Future<void> individualDGetData(String? location)async{
    var endPoint = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=94044352c8384824b41194844242401&q=$location&days=7");
    var response = await http.get(endPoint);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      setState(() async {
        fixedDateData = await body;
      });
    }else{
      throw("No data found");
    }
  }

  Future<void> getData() async{
    for(int a=0;a != oldSelectedCities.length;a++){
      if(!selectedCities.contains(oldSelectedCities[a])){
        selectedCities.add(oldSelectedCities[a].toString());
      }
    }
    data = await cl.getCurrentWeather(selectedCities[cityIndex],forecastDayNumber);
  }

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
  Connectivity myCon = Connectivity();

    return StreamBuilder(stream: myCon.onConnectivityChanged,
        builder: (_,snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            return Scaffold(
              body: Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/noInternet.png",width: 200,),
                      const Text("Sorry, You are out of internet...",style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),
                ),
              ),
            );
          }else{
            return FutureBuilder(
                future: getData(),
                builder:(context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        centerTitle: false,
                        titleSpacing: 0,
                        elevation: 0.0,
                        title: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 23,
                                backgroundImage: AssetImage("assets/profile.png"),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.pin_drop_outlined,color: Colors.blueAccent,),
                                  const SizedBox(width: 8,),
                                  DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: selectedCities[cityIndex],
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: selectedCities.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          for(int p=0;p!=selectedCities.length;p++){
                                            if(selectedCities[p]==newValue!){
                                              cityIndex=p;
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(selectedCities[cityIndex].toString(),style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 32.0),),
                            Text(DateFormat.MMMEd().format(DateTime.now()),style:const TextStyle(color: Colors.grey,fontSize: 18.0)),
                            const SizedBox(height: 40,),
                            Container(
                              width: size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                  color: myConstants.primaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: myConstants.primaryColor.withOpacity(.5),
                                        offset: const Offset(0,25),
                                        blurRadius: 12,
                                        spreadRadius: -12
                                    )
                                  ]
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    top: -40,
                                    left: 20,
                                    child: data.weatherState == ""?const Text(''):Image.asset('assets/${data.weatherState.toString().replaceAll(' ', '')}.png',width: 140,),
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    left: 20,
                                    child: Text(data.weatherState.toString(),style: const TextStyle(color: Colors.white,fontSize: 33),),
                                  ),
                                  Positioned(
                                    top: 40,
                                    right: 30,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            data.temp.toString(),
                                            style: const TextStyle(
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white70,

                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "°",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50,),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherWidget(value: "Wind Speed",data: data.wind!.toInt(),unit: "km/h",imgUrl: "assets/windspeed.png",),
                                  const SizedBox(width: 5,),
                                  WeatherWidget(value: "Humidity",data: data.humidity!,unit: '',imgUrl: "assets/humidity.png",),
                                  const SizedBox(width: 5,),
                                  WeatherWidget(value: "Max Temp",data: data.maxtemp!.toInt(),unit: 'C',imgUrl: "assets/max-temp.png",),
                                ],
                              ),
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Today",
                                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Next 6 days",
                                  style: TextStyle(
                                      color: myConstants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder(
                              future: individualDGetData(selectedCities[cityIndex]),
                              builder: (context,snapshot2){
                                if(snapshot2.connectionState == ConnectionState.done){
                                  return Expanded(child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (BuildContext context,int index){
                                      String today = DateTime.now().toString().substring(0,10);
                                      String selectedDay = fixedDateData["forecast"]["forecastday"][index]["date"].toString();
                                      double tempreture = fixedDateData["forecast"]["forecastday"][index]["day"]["avgtemp_c"];
                                      String weatherState = fixedDateData["forecast"]["forecastday"][index]["day"]["condition"]["text"].toString().replaceAll(' ', '');
                                      var parseDate = DateTime.parse(selectedDay);
                                      var newDate = DateFormat.EEEE().format(parseDate).substring(0,3);
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(cityName: selectedCities[cityIndex],index: index,fixedDateData: fixedDateData,)));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 20),
                                          margin: const EdgeInsets.only(right: 20,top: 10,bottom: 10),
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: today==selectedDay?myConstants.primaryColor:Colors.white,
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 10.0,
                                                  color: today==selectedDay?myConstants.primaryColor:Colors.black.withOpacity(.2),
                                                )
                                              ]
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("${tempreture.toInt()}C",style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: today==selectedDay?Colors.white:myConstants.primaryColor,
                                              ),),
                                              Image.asset("assets/$weatherState.png",width: 40,),
                                              // Text(weatherState),
                                              Text(newDate,style: TextStyle(
                                                  fontSize: 17,
                                                  color: today==selectedDay?Colors.white:myConstants.primaryColor,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                                }else{
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                        color: Colors.white,
                        child: Center(
                          child: SizedBox(
                              height: 40,
                              width: 40,
                              child:  CircularProgressIndicator(color: myConstants.primaryColor,)
                          ),
                        )
                    );
                  }
                }
            );
          }
        });
  }
}

