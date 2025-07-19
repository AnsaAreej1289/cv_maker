// lib/cv_maker_splash_screen.dart

import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import your home screen file

class CvMakerSplashScreen extends StatefulWidget {
  const CvMakerSplashScreen({super.key});

  @override
  State<CvMakerSplashScreen> createState() => _CvMakerSplashScreenState();
}

class _CvMakerSplashScreenState extends State<CvMakerSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the CvMakerHomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) { // Check if the widget is still in the widget tree
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const CvMakerHomeScreen(), // Navigate to your CvMakerHomeScreen
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Screen background white
      body: Stack( // To layer widgets on top of each other
        children: [
          Center( // To center the content
            child: Column( // To arrange widgets vertically
              mainAxisAlignment: MainAxisAlignment.center, // Align to center on main axis
              children: [
                // CV Icon
                Container(
                  width: 80, // Container width
                  height: 80, // Container height
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600, // Shade of blue
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: const Icon(
                    Icons.description, // A generic document/description icon
                    color: Colors.white, // Icon color white
                    size: 48, // Icon size
                  ),
                ),
                const SizedBox(height: 16), // Space between icon and text
                // CV Maker Text
                const Text(
                  'CV Maker', // Display text
                  style: TextStyle(
                    fontSize: 24, // Font size
                    fontWeight: FontWeight.bold, // Bold font weight
                    color: Colors.black, // Text color black
                  ),
                ),
              ],
            ),
          ),
          // Ad disclaimer and progress bar at the bottom
          Align( // To align the widget within the stack
            alignment: Alignment.bottomCenter, // Align to bottom center
            child: Padding( // To add padding
              padding: const EdgeInsets.only(bottom: 32.0), // Padding from the bottom
              child: Column( // Widgets arranged vertically
                mainAxisSize: MainAxisSize.min, // Column takes only necessary height
                children: [
                  const Text(
                    'This action may contain Ads.', // Ad disclaimer text
                    style: TextStyle(
                      fontSize: 12, // Font size
                      color: Colors.grey, // Text color grey
                    ),
                  ),
                  const SizedBox(height: 8), // Space between text and progress bar
                  SizedBox(
                    width: 150, // Fixed width for the progress bar
                    child: LinearProgressIndicator( // Linear progress indicator
                      value: 0.5, // Example progress value (0.0 to 1.0)
                      backgroundColor: Colors.grey.shade300, // Background color of the progress bar
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Progress color blue
                      minHeight: 4, // Thickness of the progress bar
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}