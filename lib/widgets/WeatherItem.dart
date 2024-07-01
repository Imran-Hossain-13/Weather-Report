

import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key,
    required this.value,
    required this.data,
    required this.unit,
    required this.imgUrl,
  });

  final String value;
  final String unit;
  final String imgUrl;
  final int data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 14,color: Colors.black54),
        ),
        const SizedBox(height: 8,),
        Container(
          padding: const EdgeInsets.all(6.0),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Image.asset(imgUrl,width: 90,),
        ),
        const SizedBox(height: 4,),
        Text("$data $unit",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
      ],
    );
  }
}