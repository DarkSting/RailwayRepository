import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/ui/Components/FileNotFoundError.dart';
import 'package:login_flutter/ui/Components/PerspectiveTrainBoxList.dart';
import 'package:login_flutter/Models/TrainBoxModel.dart';
import 'package:login_flutter/ui/Components/Spinners.dart';
import 'dart:async';

import 'package:login_flutter/ui/Components/TrainBoxCard.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';


class TrainBoxPage extends StatefulWidget {

  final int trainID;
  final String seatClass;
  final String destination;

  const TrainBoxPage({required this.trainID,required this.seatClass,this.destination="",super.key});

  @override
  State<TrainBoxPage> createState() => _TrainBoxPageState();
}

class _TrainBoxPageState extends State<TrainBoxPage> {


  bool isPageLoaded = false;
  int _visibleItems=0;
  double _itemExtent=0.0;
  List<dynamic>? trainBoxList = [];

  @override
  void initState() {
    _visibleItems = 8;
    _itemExtent = 270.0;
    super.initState();
    _getData();

  }

  TrainBoxModel trainBoxModel = TrainBoxModel();

  void _getData(){

    trainBoxModel.populateTrainBoxes(trainNumber: widget.trainID).then((value) {

    if(trainBoxList!=null){
      trainBoxList = trainBoxModel.receivedTrainBoxes;
      isPageLoaded = true;
      setState(() {

        print("page should refreshed");

      });
    }

    }
    ).catchError((er){
        print("an error occured");
    });



  }

  List<Color> colors = [LightColor.lightOrange,LightColor.darkgrey,LightColor.darkBlue];

  @override
  Widget build(BuildContext context){

    print(isPageLoaded.toString()+" page status");
    if (isPageLoaded) {
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
            ],
            title:Center( child: const Text('Train Boxes')),
          ),
          body: PerspectiveListView(
            visualizedItems: _visibleItems,
            itemExtent: _itemExtent,
            initialIndex: 7,
            enableBackItemsShadow: true,
            backItemsShadowColor: Theme
                .of(context)
                .scaffoldBackgroundColor,
            padding: const EdgeInsets.all(10),
            onChangeFrontItem: (value) {},
            onTapFrontItem: (value) {},
            children: List.generate(trainBoxList!.length, (index) {
              final borderColor = colors[index==0?0:index<3?1:2];
              final trainBox = trainBoxList![index] as Map<String, dynamic>;
              return TrainBoxCard(
                borderColor: borderColor,
                trainBox: trainBox,
              );
            }),
          ),
          //---------------------------------------
          // Drawer
          //---------------------------------------
          drawer: Drawer(
            child: Material(
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              child: Container(
                color: const Color(0xFF5B4382),
                padding: const EdgeInsets.all(20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----------------------------
                      // Drawer title
                      //----------------------------
                      Row(
                        children: const [
                          Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            ' Settings',
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 40),
                      //----------------------------
                      // Visible Items Control
                      //----------------------------
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          const Text(
                            ' Visible items',
                            style: TextStyle(),
                          ),
                          Expanded(
                            child: Slider(
                              value: _visibleItems.toDouble(),
                              min: 2,
                              max: 15,
                              divisions: 15,
                              label: '$_visibleItems',
                              activeColor: Colors.deepPurple[200],
                              inactiveColor: Colors.deepPurple[400],
                              onChanged: (value) {
                                setState(() {
                                  _visibleItems = value.toInt();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(height: 40),
                      //----------------------------
                      // Item Extent Control
                      //----------------------------
                      Row(
                        children: [
                          const Icon(
                            Icons.widgets,
                            color: Colors.white,
                            size: 16,
                          ),
                          const Text(
                            ' Item Extent',
                            style: TextStyle(),
                          ),
                          Expanded(
                            child: Slider(
                              value: _itemExtent,
                              min: 270,
                              max: MediaQuery
                                  .of(context)
                                  .size
                                  .height * .8,
                              label: '$_itemExtent',
                              activeColor: Colors.deepPurple[200],
                              inactiveColor: Colors.deepPurple[400],
                              onChanged: (value) {
                                setState(() {
                                  _itemExtent = value;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      const Divider(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }


    }
    return PageNotFound();
  }
}

