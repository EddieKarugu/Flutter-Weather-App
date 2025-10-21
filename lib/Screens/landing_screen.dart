import 'package:flutter/material.dart';
import 'package:phanweather/Screens/home_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fading;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    fading = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final Animation<Offset> position = Tween<Offset>(
                    begin: Offset(0, -1),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: position,
                    child: child
                  );
                },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: fading,
        child: Center(child: Image.asset('assets/images/phnaweather.png')),
      ),
    );
  }
}
