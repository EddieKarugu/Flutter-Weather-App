import 'package:flutter/material.dart';

class PredictionCard extends StatelessWidget {
  final String time;
  final String iconUrl;
  final String temp;
  final String feelsLike;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final String description;
  final String visibility;
  const PredictionCard({
    super.key,
    required this.time,
    required this.iconUrl,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.description, required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool isWideScreen = screenSize.width > 600;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: isWideScreen? screenSize.width * .45: screenSize.width * .9,
      ),
      child: Card(elevation: 10, child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(time),
          Image.network(iconUrl, width: 50, height: 50,
            color: isLightTheme? Colors.grey: null,
            colorBlendMode: isLightTheme? BlendMode.hardLight: null,
          ),
          Text(description),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Temperature'),
                      Text(temp)
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Feel Like'),
                      Text(feelsLike)
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Visibility'),
                      Text(visibility)
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 15,),
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Humidity'),
                      Text(humidity)
                    ],
                  ),
                Column(
                children: [
                const Text('Pressure'),
                      Text(pressure)
                      ],
                ),
                  Column(
                    children: [
                      const Text('Wind Speed'),
                      Text(windSpeed)
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      )),
    );
  }
}
