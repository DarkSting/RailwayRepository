import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/HomePage.dart';
import 'package:login_flutter/ui/Pages/TrainPages/SeatPage.dart';
import 'package:login_flutter/ui/Pages/TrainPages/TrainBookingPage.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';

import 'ui/Pages/LoginAndSignupPages/login.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/DashBoard.dart';
import 'package:login_flutter/ui/Pages/LoginAndSignupPages/signup.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),

        textTheme:const TextTheme(
            displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            displayMedium:TextStyle(fontSize: 72, fontWeight: FontWeight.bold) ,
            titleLarge: TextStyle(fontSize: 30,),
            titleMedium: TextStyle(fontSize: 20,),
            bodyMedium: TextStyle(fontSize: 14, )
        )
      ),
       home:const Signup(),
      // SeatCard(buttonColor: LightColor.lightOrange,chipText1: "train 1",chipText2: "Book Train",context: "train card",
      //   primaryColor: Colors.white,),
      // TrainBookingPage(trainData: TrainBooking(passengers: 5,trainNumber: 200,bookedSeats: ["a1"],seatPrice: 200)),
    );
  }
}
