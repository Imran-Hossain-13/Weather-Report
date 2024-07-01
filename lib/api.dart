import 'dart:convert';

import 'package:http/http.dart' as http;

class Weather{
  String? cityName;
  String? weatherState;
  int? humidity;
  double? temp;
  double? maxtemp;
  double? avgTemp;
  double? wind;
  String? date;
  double? lat;
  double? lon;

  Weather({this.cityName, this.temp, this.maxtemp, this.avgTemp, this.wind, this.humidity, this.weatherState, this.date, this.lat, this.lon});
  Weather.fromJson(Map<String,dynamic> json,int day){
    cityName = json["location"]["name"];
    temp = json["current"]["temp_c"];
    maxtemp = json["forecast"]["forecastday"][day]["day"]["maxtemp_c"];
    avgTemp = json["forecast"]["forecastday"][day]["day"]["avgtemp_c"];
    wind = json["current"]["wind_kph"];
    humidity = json["current"]["humidity"];
    date = json["forecast"]["forecastday"][day]["date"];
    weatherState = json["forecast"]["forecastday"][day]["day"]["condition"]["text"];
  }

  Weather.fromJson2(Map<String,dynamic> json,){
    lat = json["lat"];
    lon = json["lon"];
  }


}

class WeatherApiClient{
  Future<Weather> getCurrentWeather(String? location,int day)async{
    var endPoint = Uri.parse("http://api.weatherapi.com/v1/forecast.json?key=94044352c8384824b41194844242401&q=$location&days=7");
    var response = await http.get(endPoint);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      return Weather.fromJson(body,day);
    }else{
      throw("No data found");
    }
  }
}

class SearchCity{
  Future<Weather> getCurrentWeather(String zipCode, String conCode)async{
    var endPoint = Uri.parse("http://api.openweathermap.org/geo/1.0/zip?zip=$zipCode,$conCode&appid=d567ad070341c3e6dd1c1da7f70849bf");
    var response = await http.get(endPoint);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      return Weather.fromJson2(body);
    }else{
      throw("No City found");
    }
  }
}