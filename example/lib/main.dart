import 'package:flutter/material.dart';
import 'package:swipeintro/intro/intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Widget actions() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.lightBlue,
        ),
        width: MediaQuery.of(context).size.width * 0.30,
        height: 45,
        child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder())),
          child: const Text(
            'Continue',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Intro(
        header: const [
          'Perform cool tasks',
          'It is free',
          'Nice app and user friendly'
        ],
        subtitle: const [
          'Perform cool tasks is easy with this app',
          'It is free so you don\'t have to bother paying',
          'Nice one. A very cool app. I would recommend to friends'
        ],
        // sliderImages: const [
        //   'assets/images/slider1.png',
        //   'assets/images/slider2.png',
        //   'assets/images/slider3.png'
        // ],
        colors: const [Color(0XFF9F2C14), Color(0xFF142DB1), Color(0xFF015013)],
        count: 3,
        actions: actions(),
      )),
    );
  }
}
