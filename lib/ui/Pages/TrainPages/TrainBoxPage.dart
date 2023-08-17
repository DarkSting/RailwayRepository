import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Components/FileNotFoundError.dart';
import 'package:login_flutter/Models/TrainBoxModel.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'package:login_flutter/ui/Components/TrainBoxCard.dart';
import 'package:login_flutter/ui/Pages/BookingPages/TrainBookingPage.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'dart:async';
import 'package:login_flutter/ui/Components/DialogBox.dart';
import 'package:shared_preferences/shared_preferences.dart';


//train box page that displays train boxes details
class TrainBoxPage extends StatefulWidget {

  //train details
  final int trainID;
  final String destination;
  final List<String> stations;

  const TrainBoxPage({required this.trainID, required this.stations,this.destination="",super.key});

  @override
  State<TrainBoxPage> createState() => _TrainBoxPageState();
}

class _TrainBoxPageState extends State<TrainBoxPage> {

  Future<String> getStoredCookies() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt') ?? '';

  }

  Future<int> makeBook(String destination,String source) async{

    String storedCookies = await getStoredCookies();
    //create booking
    final urlconfirm = Uri.parse('http://192.168.8.114:8080/booking/makebook');
    final headersconfirm = {
      'Content-Type':'application/json'
    };

    final dataconfirm ={
      'seatIdArray': reservedSeats,
      'userID':storedCookies,
      'paid':true,
      'destinationID': destination.trim(),
      'station' : source.trim()

    };


    final response = await http.post(
      urlconfirm,
      headers: headersconfirm,
      body: jsonEncode(dataconfirm),
    );

    if(response.statusCode==201){

      return jsonDecode(response.body)['totalPrice'] as int;
    }
    else{
      return 0;
    }


  }


  //flags
  bool isPageLoaded = false;
  bool isPageLoading = false;
  int _visibleItems=0;
  double _itemExtent=0.0;
  List<dynamic>? trainBoxList = [];
  List<String> reservedSeats = [];

  @override
  void initState() {
    _visibleItems = 8;
    _itemExtent = 270.0;
    super.initState();
    _getData();
    selectedValue = dropdownOptions.length>0?dropdownOptions.elementAt(0):'None';

  }

  TrainBoxModel trainBoxModel = TrainBoxModel();

  void _getData(){

    //set a timer to navigate to the not found page if the server not responds in specified seconds

    //sending request to the backend
    isPageLoading = true;
    trainBoxModel.populateTrainBoxes(trainNumber: widget.trainID).then((value) {
      isPageLoading = false;
      //checks whether the trainbox list is null
    if(trainBoxList!=null){
      trainBoxList = trainBoxModel.receivedTrainBoxes;
      isPageLoaded = true;
      setState(() {

        print("page should refreshed");

      });
    }

    }
    ).catchError((er){
      isPageLoading = false;
        print("an error occured");
    });



  }

  List<Color> colors = [LightColor.lightOrange,LightColor.darkgrey,LightColor.darkBlue];

  // Default selected value
  List<String> dropdownOptions = [];
  String selectedValue = 'None';


  @override
  Widget build(BuildContext context){

    print(isPageLoaded.toString()+" page status");
    if (isPageLoaded && !isPageLoading) {
      print(trainBoxModel.receivedTrainBoxes);
      if (trainBoxModel?.receivedTrainBoxes?.isNotEmpty==true) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor: LightColor.lightOrange,
            shape: const RoundedRectangleBorder(

              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            actions: [
             //set any actions here
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: 60,
                    margin: EdgeInsets.only(right: 10),
                    child: ElevatedButton(onPressed: () async{
                      if(reservedSeats.isEmpty==true){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            width: 300,
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),

                            ),
                            behavior: SnackBarBehavior.floating,
                            content: Center( child:Text("Not Found Any Booked Seats")),
                          ),
                        );
                      }
                      else{

                        List<String> destination = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                          return  TextInputDialog(stations: widget.stations,);
                        })??[];

                        if(destination.isNotEmpty){
                          print("entered text is ${destination}");
                          makeBook(destination.elementAt(0),"20").then((value){

                            print(value);
                            Navigator.push(context,MaterialPageRoute(builder:
                                (context)=>TrainBookingPage(
                                trainData: TrainBooking(
                                    destionationStation: destination.elementAt(1),
                                    trainNumber:widget.trainID,
                                    bookedSeats: reservedSeats,
                                    seatPrice:(value.toInt()/100).toInt()
                                )
                            )
                            )
                            );
                          }).catchError((onError){
                            print(onError);
                          });

                        }

                      }


                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,

                        ),

                        child: Text('BooK Tickets',
                          style: TextStyle(color: LightColor.lightOrange,fontWeight: FontWeight.bold),
                        ))
                  ),

                ],
              )
              
            ],
            title:Center( child: const Text('Train Boxes')),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(trainBoxList!.length, (index) {
                final borderColor = colors[index==0?0:index<3?1:2];
                final trainBox = trainBoxList![index] as Map<String, dynamic>;
                return TrainBoxCard(
                  borderColor: borderColor,
                  trainBox: trainBox,
                  trainID: widget.trainID,
                  reservedSeatRef: reservedSeats,
                );}),
            ),
          ),
          //---------------------------------------
          // Drawer
          //---------------------------------------

        );

      }


    }
    else if(isPageLoading){
      return Spinner();
    }
    return PageNotFound();
  }
}

