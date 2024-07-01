import 'package:flutter/cupertino.dart';
import 'package:weather/models/city.dart';

class myProvider extends ChangeNotifier{
  List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();
  List<String> _selectedCity = [];
  List<String> get selectedCity => _selectedCity;

  void changeState(int index){
    cities[index].isSelected =! cities[index].isSelected;
    notifyListeners();
  }

}