import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phanweather/widgets/prediction_card.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import '../widgets/weather_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city = 'London';

  Future<Map<String, dynamic>> getWeatherData() async {
    final String url =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city,uk&APPID=030d92cd1665b7dc223dec042cffa152';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(title: const Text('Homescreen'), centerTitle: true),
      body: FutureBuilder(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(child: Lottie.asset('assets/lotties/starLoader.json'));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            final currentWeather = data['list'][0];
            final main = currentWeather['main'];
            final pressure = main['pressure'];
            final humidity = main['humidity'];
            final temp = ((main['temp']) - 273).toStringAsFixed(1);
            final feelsLike =
                ((main['feels_like']) - 273).toStringAsFixed(1);
            final windSpeed = currentWeather['wind']['speed'];
            final visibility = currentWeather['visibility'];
            final weather = currentWeather['weather'][0];
            final icon = weather['icon'] ?? '01d';
            final iconUrl = 'https://openweathermap.org/img/wn/$icon@2x.png';

            final List<Map<String, dynamic>> weatherList = [
              {'name': 'Temperature', 'value': '$temp °C'},
              {'name': 'Feels Like', 'value': '$feelsLike °C'},
              {'name': 'Pressure', 'value': '$pressure Pa'},
              {'name': 'Humidity', 'value': '$humidity %'},
              {'name': 'Wind Speed', 'value': '$windSpeed m/s'},
              {'name': 'Visibility', 'value': '$visibility m'},
            ];

            return LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 600;
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            width: isWideScreen ? width * .6 : width * .8,
                            height: isWideScreen? height * .4: null,
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${weather['description']}'),
                                    Image.network(
                                      iconUrl,
                                      width: isWideScreen? 70: 50,
                                      height: isWideScreen? 70: 50,
                                      color: isLightTheme? Colors.transparent: null,
                                      colorBlendMode: isLightTheme? BlendMode.screen: null,
                                    ),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      runSpacing: 10,
                                      children: [
                                        ...List.generate(
                                          weatherList.length,
                                          (index) => WeatherContainer(
                                            title: weatherList[index]['name'],
                                            data: weatherList[index]['value'],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FittedBox(child: Text(
                            'Forecast',
                            style: TextStyle(
                              fontSize: 40,
                              letterSpacing: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 10,
                            children: [
                              ...List.generate(10, (index) {
                                final weather = data['list'][index + 1];
                                final main = weather['main'];
                                final pressure = '${main['pressure']} Pa';
                                final humidity = '${main['humidity']} %';
                                final windSpeed =
                                    '${weather['wind']['speed']} m/s';
                                final visibility = '${weather['visibility']} m';
                                final temp =
                                    '${((main['temp']) - 273).toStringAsFixed(1)} °C';
                                final feelsLike =
                                    '${((main['feels_like']) - 273).toStringAsFixed(1)} °C';
                                final description =
                                    weather['weather'][0]['description'];
                                final weatherr = weather['weather'][0];
                                final time = weather['dt_txt']
                                    .toString()
                                    .substring(11, 16);
                                final icon = weatherr['icon'] ?? '01d';
                                final iconUrl =
                                    'https://openweathermap.org/img/wn/$icon@2x.png';
                                return PredictionCard(
                                  time: time,
                                  iconUrl: iconUrl,
                                  temp: temp,
                                  feelsLike: feelsLike,
                                  pressure: pressure,
                                  humidity: humidity,
                                  windSpeed: windSpeed,
                                  description: description,
                                  visibility: visibility,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
