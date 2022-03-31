import 'package:flutter/material.dart';
import 'package:pneumonia_detection/screens/homepage.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const PneumoniaDetection());
}

class PneumoniaDetection extends StatelessWidget {
  const PneumoniaDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1700, name: 'XL'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
