import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_data_base/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const Image(
                image: AssetImage("assets/StudentsRecord.png"),
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}
