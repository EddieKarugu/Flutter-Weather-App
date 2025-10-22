import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget{
  final String title;
  final String data;
  const WeatherContainer({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context){

    return Container(
      color: Colors.transparent,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, maxLines: 2,),
              Text(data)
            ],
          ),
        )
      ),
    );
  }
}