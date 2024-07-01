import 'package:flutter/material.dart';
import '../models/constants.dart';
import 'Welcome.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    Constants myConstatns = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: myConstatns.primaryColor.withOpacity(.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/get-started.png'),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Welcome()));
              },
              child: Container(
                height: 50,
                width: size.width *0.7,
                decoration: BoxDecoration(
                  color: myConstatns.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Get started",style: TextStyle(color: Colors.white,fontSize: 18),),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
