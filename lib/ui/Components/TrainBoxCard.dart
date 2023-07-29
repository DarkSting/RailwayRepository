import 'package:login_flutter/Models/TrainBoxModel.dart';
import 'package:flutter/material.dart';
import '../Theme/LightColor.dart';


class TrainBoxCard extends StatefulWidget {
  TrainBoxCard({
    super.key,
    this.borderColor=Colors.red,
    required this.trainBox,
    required this.trainID,
    required this.reservedSeatRef
  });
  final Color borderColor;
  final Map<String,dynamic> trainBox;
  final int trainID;
  List<String> reservedSeatRef;


  List<Widget> _createSeatGrid(List<bool> seats,{required dynamic state}){

    Color checkButtonState(i,String seatcode){
      if(seats[i]){
        return LightColor.red;
      }
      else if(reservedSeatRef.contains(seatcode)){
        return LightColor.green;
      }
      else{
        return LightColor.darkseeBlue;
      }
    }

    //creating the button
    Widget createButton(int i){
      Color backgroundColor = Colors.white;

      String seatID = '${trainBox['classOfBox'].toString().trim()}:${trainBox['trainBoxNumber'].toString().trim()}:${trainID.toString()}:${i}';

      return Container(
          margin:EdgeInsets.only(right: 10),
          child:
          ElevatedButton(
            child: Text("${i}"),
            style: ElevatedButton.styleFrom(
              backgroundColor: checkButtonState(i,seatID),

            ),
            onPressed: () {
            int index =i;
            print("im clicked");


            //${seatClass}:${trainBoxId}:${ trainId}:${seatId}
            if(seats[i]){
              print('seat reserved');
              return;
            }
            if(reservedSeatRef.contains(seatID)){
              print("im already there");
              print(reservedSeatRef);
              state((){
                backgroundColor =LightColor.lightGrey;
              });
            }
            else{
              reservedSeatRef.add(seatID);
              state((){
                backgroundColor =LightColor.lightGrey;
              });
            }


          },)
      );

    };

    List<Widget> createdSeats = [];

    List<Widget> currentButtons =[];

    for(int i=0;i<seats.length;i++){
      if((i+1)%3==0){
        currentButtons.add(createButton(i));
        createdSeats.add(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:currentButtons
        ));
        currentButtons = [];
      }
      else{
        currentButtons.add(
            createButton(i)
        );
      }


    }
    if(createdSeats.length>0){
      return createdSeats;
    }

    return [];
  }

  @override
  State<TrainBoxCard> createState() => _TrainBoxCardState();
}

class _TrainBoxCardState extends State<TrainBoxCard> {



  @override
  Widget build(BuildContext context) {



    return Container(
      child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        //-----------------------------
        // Card Body
        //-----------------------------
        Container(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: widget.borderColor,
              borderRadius: const BorderRadius.only(
                  topLeft:Radius.circular(0) ,
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                  topRight: Radius.circular(0)),


            ),
            //-----------------------------
            // Card Body
            //-----------------------------
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //---------------------------
                  // train id
                  //---------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.train,
                        size: 40,
                      ),
                      const SizedBox(width: 5),
                      //---------------------------
                      // boxnumber
                      //---------------------------
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            text:widget.trainBox['trainBoxNumber'].toString(),

                          ),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.trainBox['capacity'].toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                      ),

                      //---------------------------
                      // class
                      //---------------------------
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.class_,
                        size: 40,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.trainBox['classOfBox'].toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Column(
                    children:widget._createSeatGrid(List<bool>.from(widget.trainBox['seats']),state: setState ),
                  )

                ],
              ),
            ),
          ),
        ),
      ],
    )
    );
  }
}

