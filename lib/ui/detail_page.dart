import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/api.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/ui/Welcome.dart';

import '../widgets/WeatherItem.dart';
import 'home.dart';

class DetailPage extends StatefulWidget {
  final String cityName;
  final int index;
  Map<String,dynamic> fixedDateData = {};
  DetailPage({super.key,required this.index,required this.cityName,required this.fixedDateData,});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WeatherApiClient cl = WeatherApiClient();
  Weather data = Weather();

  Future<void> getData() async{
    data = await cl.getCurrentWeather(widget.cityName,widget.index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();


    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return Scaffold(
            backgroundColor: myConstants.secondColor,
            appBar: AppBar(
              backgroundColor: myConstants.secondColor,
              centerTitle: true,
              elevation: 0.0,
              title: Text(widget.cityName,style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                fontSize: 26
              ),),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: (){
                  Navigator.of(context).pop(const Home());
              },
                icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 30),
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (con)=>const Welcome()));
                    },
                    icon: const Icon(Icons.settings,color: Colors.white,)
                )
              ],
            ),
            body: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: SizedBox(
                    height: 190,
                    width: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext context,int index){
                        Map<String,dynamic> fixedDateData = widget.fixedDateData;
                        String today = DateTime.now().toString().substring(0,10);
                        String selectedDay = fixedDateData["forecast"]["forecastday"][index]["date"].toString();
                        double tempreture = fixedDateData["forecast"]["forecastday"][index]["day"]["avgtemp_c"];
                        String weatherState = fixedDateData["forecast"]["forecastday"][index]["day"]["condition"]["text"].toString().replaceAll(' ', '');
                        var parseDate = DateTime.parse(selectedDay);
                        var newDate = DateFormat.EEEE().format(parseDate).substring(0,3);

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          margin: const EdgeInsets.only(right: 20,top: 10,bottom: 10),
                          width: 90,
                          decoration: BoxDecoration(
                              color: widget.index==index?Colors.white:const Color(0xff9ebcf9),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 1),
                                  blurRadius: 5.0,
                                  color: widget.index==index?myConstants.primaryColor:Colors.black.withOpacity(.3),
                                )
                              ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${tempreture.toInt()}C",style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: widget.index==index?myConstants.primaryColor:Colors.white,
                              ),),
                              Image.asset("assets/$weatherState.png",width: 40,),
                              Text(newDate,style: TextStyle(
                                  fontSize: 17,
                                  color: widget.index==index?myConstants.primaryColor:Colors.white,
                                  fontWeight: FontWeight.w500
                              ),),
                            ],
                          ),
                        );
                      }
                    ),
                  )
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: size.height*.55,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)
                      )
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -50,
                            left: 20,
                            right: 20,
                            child: Container(
                              width: size.width*.7,
                              height: 320,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.center,
                                  colors: [
                                    Color(0xffa9c1f5),
                                    Color(0xff6696f5),
                                  ]
                                ),
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(.2),
                                    offset: const Offset(0, 25),
                                    blurRadius: 3,
                                    spreadRadius: -10,
                                  )
                                ],
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
                                    bottom: 160,
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
                                  Positioned(
                                    bottom: 20,
                                      left: 20,
                                      child: Container(
                                        width: size.width*.8,
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  ),
                                ],
                              ),
                            ),
                        ),
                        Positioned(
                            left: 20,
                            right: 20,
                            top: 280,
                            child: SizedBox(
                              height: 200,
                              width: size.width*.9,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 7,
                                  itemBuilder: (BuildContext context, int index){
                                    Map<String,dynamic> fixedDateData = widget.fixedDateData;
                                    // String today = DateTime.now().toString().substring(0,10);
                                    var selectedDay = fixedDateData["forecast"]["forecastday"][index]["date"].toString();
                                    double maxTemp = fixedDateData["forecast"]["forecastday"][index]["day"]["maxtemp_c"];
                                    double minTemp = fixedDateData["forecast"]["forecastday"][index]["day"]["mintemp_c"];
                                    String weatherState = fixedDateData["forecast"]["forecastday"][index]["day"]["condition"]["text"].toString().replaceAll(' ', '');
                                    var parseDate = DateTime.parse(selectedDay);
                                    var newDate = DateFormat('d MMM EEEE').format(parseDate);

                                    return Container(
                                      margin:const EdgeInsets.only(
                                        left: 10,right: 10,top: 10,bottom: 5,
                                      ),
                                      // width: size.width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow:const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(0, 1)
                                            )
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(newDate,style: const TextStyle(color: Color(0xff6696f5),fontWeight: FontWeight.bold),),
                                            Row(
                                              children: [
                                                Text(maxTemp.toInt().toString(),style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                                const Text('/',style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                                Text(minTemp.toInt().toString(),style:const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset('assets/$weatherState.png',width: 30,),
                                                SizedBox(
                                                  width: 90,
                                                  child: Text(data.weatherState.toString()),
                                                )

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }
}
