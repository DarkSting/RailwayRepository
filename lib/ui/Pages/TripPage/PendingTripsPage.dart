import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/Models/TripModel.dart';
import 'package:login_flutter/ui/Components/TripCard.dart';
import 'package:login_flutter/ui/Pages/MapPages/MapPage.dart';
import '../TrainPages/TrainBoxPage.dart';


class PendingTripsPage extends StatefulWidget {

   PendingTripsPage({ super.key});

  @override
  State<PendingTripsPage> createState() => _PendingTripsPageState();
}

class _PendingTripsPageState extends State<PendingTripsPage> {


  List<dynamic>? tripList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrips().then((value) {
        setState(() {
          tripList =  value!['trips'];
          print(tripList);
        });

    }).catchError((error){

      print(error);
    });

  }


  Future<Map<String,dynamic>?> getTrips ()async{

    final headers = {
      'Content-Type':'application/json'
    };

    http.Response  response = await http.get(Uri.parse("http://192.168.8.114:8080/trip/gettrips"),
        headers: headers);

    if(response.statusCode==200){
      print("data received");
      return jsonDecode(response.body);
    }
    else{
      return null;
    }
  }

  List<TripModel> trips = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(child:  ListView.builder(
        itemCount: tripList==null?0:tripList!.length,
        itemBuilder: (context, index) {
          trips.add(TripModel.fromJson(tripList![index]));
          TripModel current = trips[index];

          if(current.routeData==null){
            current.getRouteData().then((value) {
                  setState(() {

                  });
            }).catchError((err){

            });
          }


          return  TripCard(heading: current.routeData==null?"Unknown Trip Route":
          '${current!.routeData!.startPoint} ${current!.routeData!.endPoint!}',
            subheading: current.route!, arrival: current.arrival!, departure: current.departure!,
            onPressedBook: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainBoxPage(trainID:int.parse(current.train!))));

              },
            onPressedMap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPage(stations: current.routeData!.stops!)));
            },
          );

        },
      )
    );

  }
}
