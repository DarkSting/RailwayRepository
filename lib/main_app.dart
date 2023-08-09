import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/BookingPage.dart';
import 'package:login_flutter/ui/Components/FileNotFoundError.dart';
import 'package:login_flutter/ui/Components/TrainBoxCard.dart';
import 'package:login_flutter/ui/Components/TrainBoxCardStyle2.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/DashBoard.dart';
import 'package:login_flutter/ui/Pages/LoginAndSignupPages/signup.dart';
import 'package:login_flutter/ui/Pages/BookingPages/TrainBookingPage.dart';
import 'package:login_flutter/ui/Pages/MapPages/MapPage.dart';
import 'package:login_flutter/ui/Pages/MapPages/Socket.dart';
import 'package:login_flutter/ui/Pages/TrainPages/TrainBoxPage.dart';
import 'package:login_flutter/ui/Pages/TripPage/PendingTripsPage.dart';
//import 'package:login_flutter/ui/Components/TrainBoxCardStyle2.dart';

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

       home: Signup(),




      //TrainBoxPage(trainID: 200),
      // SeatCard(buttonColor: LightColor.lightOrange,chipText1: "train 1",chipText2: "Book Train",context: "train card",
      //   primaryColor: Colors.white,),
      // TrainBookingPage(trainData: TrainBooking(passengers: 5,trainNumber: 200,bookedSeats: ["a1"],seatPrice: 200)),
    );
  }
}
