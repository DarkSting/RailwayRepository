import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookedModel.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/Models/TrainBookedModel.dart';
import 'dart:convert';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Components/BookingCard.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {


  List<BookedModel> receivedBooking = [];

  Future<Map<String,dynamic>?> getBookings() async{

    final url = Uri.parse('http://192.168.8.114:8080/booking/getbookings');

    final headers = {
      'Content-Type' : 'application/json',
    };

    final body = {
      "userID" : 200,
    };

    try{
      http.Response response = await http.post(url,
        headers:headers,
        body: jsonEncode(body),
      );

      if(response.statusCode==200){

        List<dynamic> foundBookings =  jsonDecode(response.body);


        for(Map<String,dynamic> current in foundBookings){

          receivedBooking.add(BookedModel.fromJson(current));

        }

      }
      else{

        print(jsonDecode(response.body));
      }
    }
    catch(e){

      print(e);
      return null;

    }



  }

  List<Widget> getBookingList(){

    List<Widget> currentList = [];

    for(BookedModel current in receivedBooking){
      currentList.add(BookingCard(totalPrice: current.totalPrice??0,bookedDate: current.bookedDate??"",
        bookedSeats: current.bookedSeats??[],isPaid: current.isPaid??false,

      )

      );
      print(current);
    }

    return currentList;
  }

  Widget currentWidget = Center(
    child: Container(
      child: Center(
        child: Text("No booking available"),
      ),
    ),
  );


  @override
  Widget build(BuildContext context) {


    if(receivedBooking.isEmpty==true){
      getBookings().then((value) => {
        currentWidget = Column(
          children: getBookingList(),
        ),
        setState(() {

        })

      }).catchError((onError)=>{

      });
    }

    return currentWidget;
  }

}

