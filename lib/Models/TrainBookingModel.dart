import 'package:flutter/material.dart';
//model for booking the train

class TrainBooking {
  int trainNumber;
  int passengers;
  List<String> bookedSeats;
  String userID;
  int seatCount =0;
  int totalPrice=0;
  int seatPrice ;
  String seatType;
  Widget? currentWidget;
  String destionationStation;

  TrainBooking({this.bookedSeats=const[],this.passengers=0,this.trainNumber=0,
    this.userID="",this.seatPrice=0,this.seatType="",this.currentWidget,required this.destionationStation});







}
