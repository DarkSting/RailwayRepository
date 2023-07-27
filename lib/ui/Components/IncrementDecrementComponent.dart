import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';

class IncrementDecrementCard extends StatefulWidget {

  final String title;
  TrainBooking bookingData;
  final double height;
  final Function() callback;

  IncrementDecrementCard({this.title="hello", required this.bookingData,this.height=60,required this.callback,super.key});

  @override
  _IncrementDecrementCardState createState() => _IncrementDecrementCardState();
}

class _IncrementDecrementCardState extends State<IncrementDecrementCard> {

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: widget.height,
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color :LightColor.lightOrange,
                width:1.0,
              )
          ),
          child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.bookingData.seatCount > 0
                    ?  IconButton(
                    icon: Icon(Icons.remove),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        widget.bookingData.seatCount--;
                        widget.bookingData.totalPrice = widget.bookingData.totalPrice - widget.bookingData.seatPrice;
                        widget.bookingData.passengers = widget.bookingData.seatCount;
                        widget.callback();

                      });
                    })
                    : Container(),
                Text("Seat Count:   ${widget.bookingData.seatCount}",style: Theme.of(context).textTheme.titleMedium,),
                IconButton(
                    icon: Icon(Icons.add),
                    color: LightColor.lightBlue,
                    onPressed: () {
                      setState(() {
                        widget.bookingData.seatCount++;
                        widget.bookingData.totalPrice = widget.bookingData.totalPrice + widget.bookingData.seatPrice;
                        widget.callback();
                        widget.bookingData.passengers = widget.bookingData.seatCount;
                      });
                    }

                    )
              ],
            ));


  }
}