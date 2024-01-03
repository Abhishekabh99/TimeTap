import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kjbmg/screens/home.dart';
import '../controller/home_controller.dart';

class SplashScreen extends StatelessWidget {
  final HomeController controller =
      Get.put(HomeController()); // Initialize HomeController

  @override
  Widget build(BuildContext context) {
    _navigateToHome(); // Call the function to navigate after 3 seconds

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Text(
          'KJBN',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Function to navigate after 3 seconds
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3));
    Get.off(HomePage());
  }
}
