// ignore_for_file: unused_import

import 'dart:async';

import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/screens/bottom_nav_bar/nav_bar.dart';
import 'package:expense_tracker/screens/signin/sign_in.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/icons/logo.png"))),
              ),
            ),
           verticalSpaceresponsive(0.06, context),
            const CircularProgressIndicator(
              color:mainColor,
            )
          ],
        ));
  
  }
}
