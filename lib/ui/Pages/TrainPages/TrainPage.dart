import "dart:async";

import "package:flutter/material.dart";
import "package:login_flutter/ui/Components/RoundBordersCard.dart";
import "package:login_flutter/ui/Pages/TrainPages/TrainBoxPage.dart";
import "package:login_flutter/ui/Theme/LightColor.dart";
import "package:login_flutter/ui/Components/TopicBar.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {

  Map<String,dynamic>? receivedTrains;

  Future<Map<String,dynamic>?> getTrains ()async{

    final headers = {
      'Content-Type':'application/json'
    };
    http.Response  response = await http.post(Uri.parse("http://192.168.8.114:8080/train/gettrains"),
        headers: headers);

    if(response.statusCode==200){
      return jsonDecode(response.body);
    }
    else{
      return null;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  List<Widget> generateTrainList(Map<String,dynamic> map){

    List<Widget> currentList = [];



    if(map.isNotEmpty==true){
      for(int i=0;i<map['trains'].length;i++){

        Function() buttonOnPressed = (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainBoxPage(trainID:map['trains'][i]['trainNumber'] as int )));
        };
        currentList.add(
            RoundBordersCard(buttonColor: LightColor.lightOrange,TrainName:(map['trains'][i]['name'].toString()),
              TrainID:(map['trains'][i]['trainNumber'].toString()) ,
              chipText2: "Book Train",context: "train card",
              primaryColor: Colors.white,onPressed: buttonOnPressed,
            )
        );

      }

      return currentList;
    }
    else{
      
      currentList.add(SizedBox(height: 100));
      currentList.add(
        Center(child:  Text(
          "No trains to show",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color:Colors.black,
          ),
        ),)
      );
      return currentList;
    }
  }

  @override
  Widget build(BuildContext context) {

    if(receivedTrains==null){


      getTrains().then((value) => {

      setState((){
        receivedTrains = value;
      })

      }).catchError((error)=>{
        receivedTrains = null
      });
    }


    return Container(

      child:Column(
        children: <Widget>[
          SizedBox(height: 10,),
          TopicBar("Available Trains", LightColor.lightOrange, LightColor.background, 15,30),
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: generateTrainList(receivedTrains==null?{}:receivedTrains as Map<String,dynamic>)
          ),
        ),

        ],
      ),
    );


  }
}
