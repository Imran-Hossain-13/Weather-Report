import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/ui/home.dart';
import 'package:weather/ui/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCity = City.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    // myProvider mp = myProvider();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondColor,
        title: Text("${selectedCity.length} selected",style: const TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (BuildContext context,int index){
            return Consumer<myProvider>(builder: (context, value, child){
              return GestureDetector(
                onTap: (){
                  value.changeState(index);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .08,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: myConstants.primaryColor.withOpacity(0.08),
                      border: cities[index].isSelected == true? Border.all(
                          color: myConstants.secondColor.withOpacity(0.6),
                          width: 2
                      ):Border.all(color: Colors.white,width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: myConstants.primaryColor.withOpacity(.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ]
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        cities[index].isSelected == true?"assets/checked.png":"assets/unchecked.png",
                        width: 30,
                      ),
                      const SizedBox(width: 10,),
                      Text(
                        cities[index].city,
                        style: TextStyle(
                            fontSize: 20,
                            color: cities[index].isSelected == true? myConstants.primaryColor:Colors.black54
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (con)=>const Home()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        hoverColor: myConstants.secondColor.withOpacity(0.2),
        backgroundColor: myConstants.secondColor,
        child: const Icon(Icons.pin_drop),
      ),
    );
  }
}
