import 'package:flutter/material.dart';
import 'package:login_flutter/Models/ScheduleModel.dart';
import 'package:login_flutter/ui/Pages/MapPages/MapPageByStation.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'package:login_flutter/Models/ScheduleModel.dart';

import '../Pages/MapPages/MapPage.dart';

class ScheduleCard extends StatelessWidget {

  String title;
  String departure;
  String arrival;
  String trainName;
  List<Stations> stations;
  String passengers;
  Train train;

 ScheduleCard({required this.train,required this.stations,required this.title,required this.departure,required this.arrival,
   required this.passengers,required this.trainName,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.train),
              title: Text(title,style: TextStyle(color: LightColor.darkBlue),),

              subtitle: Text('Departure ${departure}\nArrival ${arrival}',style:Theme.of(context).textTheme.bodyMedium ,),
            ),
            Text('train ${trainName}',style: Theme.of(context).textTheme.bodyMedium,),
            Text('capacity ${passengers}',style: Theme.of(context).textTheme.bodyMedium,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text('SEE TRIP'),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MapPageByStation(stations: stations,trainNumber: train.trainNumber,)));

                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
