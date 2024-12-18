import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location_tracker/screens/attendance_page.dart';
import 'package:location_tracker/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomePage after 3 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset(
              'assets/splashimage.png',// Path to your image
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            // const Text(
            //   "Welcome to Attendance App",
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
            const SizedBox(height: 30),
            // Horizontal loading animation
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                color: Colors.white,
                backgroundColor: const Color.fromARGB(255, 9, 3, 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
