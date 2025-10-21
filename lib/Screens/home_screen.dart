import 'package:flutter/material.dart';

import '../widgets/weather_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homescreen'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;
          double width = constraints.maxWidth;
          double height = constraints.maxHeight;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: isWideScreen ? height * .5 : height * .35,
                      width: isWideScreen ? width * .6 : width * .8,
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Temp 40 °C'),
                              const Icon(Icons.cloud, size: 100),
                              const Text('Partially Cloudy'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 10,
                      children: [
                        ...List.generate(9, (index) => WeatherContainer(),)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
