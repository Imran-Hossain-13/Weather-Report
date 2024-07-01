class City{
  late bool isSelected;
  late final String city;
  late final String country;
  late final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  static List<City> citiesList = [
    City(
        isSelected: false,
        city: 'Dhaka',
        country: 'BD',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Cumilla',
        country: 'BD',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Noakhali',
        country: 'BD',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Feni',
        country: 'BD',
        isDefault: false),
    City(
        isSelected: false,
        city: 'London',
        country: 'United Kindgom',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Tokyo',
        country: 'Japan',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Delhi',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Beijing',
        country: 'China',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Paris',
        country: 'Paris',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Rome',
        country: 'Italy',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Lagos',
        country: 'Nigeria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Amsterdam',
        country: 'Netherlands',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Barcelona',
        country: 'Spain',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Miami',
        country: 'United States',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Vienna',
        country: 'Austria',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Berlin',
        country: 'Germany',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Toronto',
        country: 'Canada',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Brussels',
        country: 'Belgium',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Nairobi',
        country: 'Kenya',
        isDefault: false),
  ];

  static List<City> getSelectedCities(){
    List<City> selectedCity = City.citiesList;
    return selectedCity.where((city) => city.isSelected == true).toList();
  }

  static List getTrueCitie(){
    List selectedCities = [];
    List<City> allCities = City.citiesList;
    for(int x = 0; x != City.citiesList.length; x++){
      String? city;
      if(allCities[x].isSelected == true){
        city = allCities[x].city;
      }
      if(city!=null){
        selectedCities.add(city.toString());
      }
    }
    return selectedCities;
  }
}