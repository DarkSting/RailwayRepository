import 'package:flutter/material.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';

class TripCard extends StatelessWidget {

  String heading;
  String subheading;
  String arrival;
  String departure;
  Function() onPressedBook;
  Function() onPressedMap;

 TripCard({ required this.heading,
    required this.subheading,
    required this.arrival,
    required this.departure,
    required this.onPressedBook,
    required this.onPressedMap
    ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes the shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  bottomLeft: Radius.circular(3.0),
                ),
                color: LightColor.lightGrey,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    SizedBox(height: 10,),
                    Text(heading,style: Theme.of(context).textTheme.headlineSmall,),
                    SizedBox(height: 5,),
                    Text("Route ID : "+subheading,style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height:3),
                    Text("Arrival : ${arrival.split('T')[0]}\n${arrival.split('T')[1]}",style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height:3),
                    Text("Departure : ${departure.split('T')[0]}\n${departure.split('T')[1]}",style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height:15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.white,
                                backgroundColor: LightColor.darkBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
                            ),
                            onPressed: onPressedMap,
                            child: Text('See Stops'),
                          ),
                        ),
                        Container(

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.white,
                                backgroundColor: LightColor.lightOrange,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))

                            ),
                            onPressed: onPressedBook,
                            child: Text('Book Train'),
                          ),
                        ),
                      ],
                    )

                  ]
                )
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/train1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}