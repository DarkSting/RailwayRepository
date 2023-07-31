import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookedModel.dart';

class BookingCard extends StatelessWidget {

  bool isPaid;
  List<String>? bookedSeats;
  int totalPrice;
  String bookedDate;

   BookingCard({
    super.key,
    this.isPaid=false,
    this.bookedSeats=const [],
    this.totalPrice=0,
    this.bookedDate=""

  });


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.white,
      textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Color(0xff6528F7),
              Color(0xff6528F7)

            ])

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text(
                  //   "Click to buy Fuel ",
                  //   style: TextStyle(
                  //       fontFamily: 'Raleway',
                  //       color: Colors.white,
                  //       fontSize: 25.0,
                  //       fontWeight: FontWeight.w700),
                  // ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "Total Price : ${this.totalPrice}",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,

                    child: Text(
                      "Booked Date : ${this.bookedDate}",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),

                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 120, height: 27),
                    child: ElevatedButton(
                      style: style,
                      child: const Text(
                        "Booked Seats",
                        style: TextStyle(color: Color(0xff5956E9)),
                      ),
                      onPressed: (){
                        if(!isPaid){

                        }
                      }
                      ,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 80,
                width: 80,
                child: Icon(Icons.bookmark_add,size: 50,color: Colors.white,)
            )
          ],
        ),
      ),
    );
  }
}