import 'package:flutter/material.dart';
import 'package:login_flutter/Models/ScheduleModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_flutter/ui/Components/ScheduleCard.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';

class SchedulePage extends StatefulWidget {


  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}


class _SchedulePageState extends State<SchedulePage> {


  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSchedules().then((value){

      isLoading = false;
      setState(() {
        if(value.isNotEmpty){
          for(int i=0;i<value.length;i++){
            tripList.add(ScheduleModel.fromJson(value[i]));
            print(tripList[i].trip!.departure!);
          }
        }
      });

    }).catchError((onError){

      isLoading = false;
      print(onError);

    });
  }

  List<ScheduleModel> tripList = [];

  Future<List<dynamic>> getSchedules() async{

    final headers = {
      'Content-Type':'application/json'
    };

    http.Response  response = await http.get(Uri.parse("http://192.168.8.114:8080/trip/getcurrenttrips"),
        headers: headers);

    if(response.statusCode==200){
      print("data received");
      return jsonDecode(response.body);
    }
    else{
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {

    if(!isLoading && tripList.isNotEmpty){
      return Expanded(child:ListView.builder(
          itemCount: tripList.length,
          itemBuilder: (context,index) {

            ScheduleModel current = tripList[index];

            return ScheduleCard(title:'Route ${current.trip!.route!}',train: current!.train!,stations: current!.stations!,departure: current!.trip!.departure!,arrival:
            current!.trip!.departure! ,trainName: current!.train!.name!,passengers: current!.train!.totalSeats!.toString(),);
          }
      )
      );
    }
    else if(!isLoading && tripList.isEmpty){
          return Container(
            child: Center(
              child: Text('No available trips',style: Theme.of(context).textTheme.bodyMedium,),
            ),
          );
    }
    else{
      return Expanded(child: Spinner());
    }

  }
}
