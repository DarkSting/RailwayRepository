import "package:flutter/material.dart";
import "package:login_flutter/ui/Components/RoundBordersCard.dart";
import "package:login_flutter/ui/Theme/LightColor.dart";
import "package:login_flutter/ui/Components/TopicBar.dart";

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child:Column(
        children: <Widget>[
          SizedBox(height: 10,),
          TopicBar("Available Trains", LightColor.lightOrange, LightColor.background, 15,30),
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                RoundBordersCard(buttonColor: LightColor.lightOrange,chipText1: "train 1",chipText2: "Book Train",context: "train card",
                  primaryColor: Colors.white,
                ),
                RoundBordersCard(buttonColor: LightColor.lightOrange,chipText1: "train 2",chipText2: "Book Train",context: "train card",
                  primaryColor: Colors.white,
                ),
                RoundBordersCard(buttonColor: LightColor.lightOrange,chipText1: "train 3",chipText2: "Book Train",context: "train card",
                  primaryColor: Colors.white,
                ),
                RoundBordersCard(buttonColor: LightColor.lightOrange,chipText1: "train 4",chipText2: "Book Train",context: "train card",
                  primaryColor: Colors.white,
                ),

            ],
          ),
        ),
      )
        ],
      ),
    );


  }
}
