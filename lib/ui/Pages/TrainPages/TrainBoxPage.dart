import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Components/FileNotFoundError.dart';
import 'package:login_flutter/Models/TrainBoxModel.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'package:login_flutter/ui/Components/TrainBoxCard.dart';
import 'package:login_flutter/ui/Pages/BookingPages/TrainBookingPage.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'dart:async';


//train box page that displays train boxes details
class TrainBoxPage extends StatefulWidget {

  //train details
  final int trainID;
  final String destination;

  const TrainBoxPage({required this.trainID,this.destination="",super.key});

  @override
  State<TrainBoxPage> createState() => _TrainBoxPageState();
}

class _TrainBoxPageState extends State<TrainBoxPage> {


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
                    child: ElevatedButton(onPressed: (){
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
                          Navigator.push(context,MaterialPageRoute(builder:
                              (context)=>TrainBookingPage(
                                  trainData: TrainBooking(
                                    trainNumber:widget.trainID,
                                    bookedSeats: reservedSeats,
                                    seatPrice: 200
                                  )
                              )
                          )
                          );
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

