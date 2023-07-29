import 'package:login_flutter/Models/TrainBoxModel.dart';
import 'package:flutter/material.dart';

import '../Theme/LightColor.dart';


class TrainBoxCard extends StatefulWidget {
  TrainBoxCard({
    super.key,
    this.borderColor=Colors.red,
    required this.trainBox,
  });
  final Color borderColor;
  final Map<String,dynamic> trainBox;

  List<int> reservedSeats = [];

  List<Widget> _createSeatGrid(List<bool> seats,{required dynamic state}){

    //creating the button
    Widget createButton(int i){
      Color backgroundColor = Colors.white;

      if(seats[i]){
        backgroundColor = LightColor.red;
      }
      else if(reservedSeats.contains(i)){
        backgroundColor = LightColor.lightGrey;
      }
      else{
        backgroundColor = LightColor.green;
      }
      return Container(
          margin:EdgeInsets.only(right: 10),
          child:
          ElevatedButton(
            child: Text("${i}"),
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,


            ),
            onLongPress: (){
              print("hello");
            },
            onPressed: () {
            int index =i;
            print("im clicked");
            if(reservedSeats.contains(index)){

            }
            else{
              reservedSeats.add(index);
              state(){

              }
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

  Function? updateParentWidget(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        //-----------------------------
        // Card Tab
        //-----------------------------
        Align(
          heightFactor: 1,
          alignment: Alignment.center,
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: widget.borderColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child:
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [

                const Icon(
                  Icons.class_,
                  color: Colors.white,
                ),
                SizedBox(width: 10,),
                Text('${widget.trainBox['classOfBox']} class',style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold
                ),)

              ],
            ),

          ),
        ),
        //-----------------------------
        // Card Body
        //-----------------------------
        Expanded(
          child: Container(
            width: double.infinity,
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
                    children:widget._createSeatGrid(List<bool>.from(widget.trainBox['seats']),state: updateParentWidget() ),
                  )

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

