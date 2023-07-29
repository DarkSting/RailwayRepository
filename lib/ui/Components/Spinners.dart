import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: LightColor.background
        ),
        child: Center(
          child: SpinKitPouringHourGlass(
              color: LightColor.darkOrange,
              size: 80),
        ),
      );




  }
}

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: LightColor.background
        ),
        child: Center(
          child: SpinKitPouringHourGlass(
              color: LightColor.darkOrange,
              size: 80),
        ),
      ),
    );;
  }
}


