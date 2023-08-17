import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookedModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login_flutter/ui/Components/BookingCard.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BookingPage extends StatefulWidget {
  const BookingPage({super.key});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {


  List<BookedModel> receivedBooking = [];
  bool isLoading = true;

  @override
  initState(){
    super.initState();
    getBookings().then((value) {
      isLoading = false;
      setState(() {

      });
    })
    .catchError((onError){
      isLoading = false;
  });

  }

  Future<String> getStoredCookies() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt') ?? '';

  }

  Future<Map<String,dynamic>?> getBookings() async{

    String storedCookies = await getStoredCookies();

    final url = Uri.parse('http://192.168.8.114:8080/booking/getbookings');

    final headers = {
      'Content-Type' : 'application/json',
    };

    final body = {
      "userID" : storedCookies,
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

      ),

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

    if(receivedBooking.isNotEmpty==true && !isLoading){
      List<Widget> bookinglist = getBookingList();
      return currentWidget = Expanded(child:ListView.builder(
            itemCount: bookinglist.length,
          itemBuilder: (context,index) {
            return bookinglist[index];
          })
    );

    }
    else if(receivedBooking.isEmpty==true && !isLoading){
      return Container(
        child: Center(
          child: Text('No available bookings',style: Theme.of(context).textTheme.bodyMedium,),
        ),
      );
    }
    return Expanded(child: Spinner());
  }

}

