import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/Models/TripModel.dart';
import 'package:login_flutter/ui/Components/TripCard.dart';
import 'package:login_flutter/ui/Pages/MapPages/MapPage.dart';
import '../../Components/Spinners.dart';
import '../TrainPages/TrainBoxPage.dart';


class PendingTripsPage extends StatefulWidget {

   PendingTripsPage({ super.key});

  @override
  State<PendingTripsPage> createState() => _PendingTripsPageState();
}

class _PendingTripsPageState extends State<PendingTripsPage> {


  List<dynamic>? tripList;

  bool isLoading=true;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrips().then((value) {
      isLoading = false;

          tripList =  value!['trips'];
          for(int i=0;i<tripList!.length!;i++){
            trips.add(TripModel.fromJson(tripList![i]));
          }
          for(int i=0;i<trips!.length!;i++){

            if(i==trips.length-1){
              trips[i].getRouteData().then((value) {

                setState(() {

                });
              });

            }
            else{
              trips[i].getRouteData();
            }
          }

          print(tripList);


    }).catchError((error){
      isLoading = false;
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


    if(!isLoading && tripList!.isNotEmpty){
      return Expanded(child:  ListView.builder(
        itemCount: tripList==null?0:tripList!.length,
        itemBuilder: (context, index) {
          TripModel current = trips[index];



          return  TripCard(heading: current.routeData==null?"Unknown Trip Route":
          '${current!.routeData!.startPoint} ${current!.routeData!.endPoint!}',
            subheading: current.route!, arrival: current.arrival!, departure: current.departure!,
            onPressedBook: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainBoxPage(trainID:int.parse(current.train!),
                stations: current!.routeData!.stops!,
              )));

            },
            onPressedMap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPage(stations: current.routeData!.stops!)));
            },
          );

        },
      )
      );
    }
    else if(!isLoading && tripList!.isEmpty){
      return Container(
        child: Center(
          child: Text('No available bookings',style: Theme.of(context).textTheme.bodyMedium,),
        ),
      );
    }
    else{
      return Expanded(child: Spinner());
    }


  }
}
