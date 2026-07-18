import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? Colors.black
            : Colors.white,
      ),
      height: double.infinity,
      width: double.infinity,
      child: MediaQuery.platformBrightnessOf(context) == Brightness.dark
          ? Image.asset('assets/icon/logo_dark.png')
          : Image.asset('assets/icon/logo_light.png'),
    );
  }
}
