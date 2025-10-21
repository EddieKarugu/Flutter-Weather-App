import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget{
  const WeatherContainer({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      height: 100,
      color: Colors.transparent,
      width: 140,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00'),
              Icon(Icons.sunny),
              Text('Temp 40 °C')
            ],
          ),
        )
      ),
    );
  }
}