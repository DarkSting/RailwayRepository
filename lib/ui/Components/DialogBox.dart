import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/StationModel.dart';

class TextInputDialog extends StatefulWidget {

  List<String> stations;

  TextInputDialog({ required this.stations,super.key});

  @override
  _TextInputDialogState createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {



  String selectedValue = 'None'; // Default selected value
  // List of options for the dropdown
  List<String> dropdownOptions=['None'];

  @override
  initState(){

    getTrainStations(widget.stations).then((value) {

      print(value.length);
      stationList = value;
      setState(() {

      });

    }).catchError((onError){
      print("hello"+onError.toString());
    });
    //socket?.connectToSocket();
  }

  List<Station> stationList =[];

  Future<List<Station>> getTrainStations(List<String> stations) async{

    print(stations[0]);
    final url = Uri.parse('http://192.168.8.114:8080/station/getstationsbyid');
    final headers = {
      'Content-Type':'application/json'
    };

    final stationBody = {
      'stationIDArray' : stations
    };

    final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(stationBody)
    );
    print(stations);

    if(response.statusCode==200){
      print("good respose received");

      List<dynamic> list = jsonDecode(response.body)['foundStation'];

      List<Station> _stationList =[];
      for(Map<String,dynamic> current in list){
        _stationList.add(Station.fromJson(current));
      }

      return _stationList;
    }
    else{
      throw Exception("bad response "+jsonDecode(response.body));
      return [];
    }
  }



  @override
  Widget build(BuildContext context) {

    if(stationList.length>0){

      if(dropdownOptions.length-1<stationList.length){
        for(Station currentStation in stationList){
          print(currentStation.stationNumber.toString()+"hello");
          dropdownOptions.add(currentStation!.stationName!);
        }
      }

      return AlertDialog(
        title: Text('Input Destination Station'),
        content: DropdownButton<String>(
          value: selectedValue,
          onChanged: (newValue) {
            setState(() {

              if(newValue!='None'){
                for(int i=0;i<stationList.length;i++){
                  selectedValue=newValue!;
                  if(stationList.elementAt(i).stationName==newValue){
                    selectedValue =stationList.elementAt(i).stationNumber!;

                  }
                }
              }
              selectedValue=newValue!;
            }
            )
            ;
          },

          items: dropdownOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: <Widget>[

          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              //converting station name to number
              List<String> enteredText = [];
              for(int i=0;i<stationList.length;i++){
                if(stationList.elementAt(i).stationName==selectedValue){
                  enteredText.add(stationList.elementAt(i).stationNumber!);
                  enteredText.add(stationList.elementAt(i).stationName!);
                }
              }
              Navigator.of(context).pop(enteredText); // Close the dialog and return the entered text
            },
            child: Text('Save'),
          ),
        ],
      );
    }
    else{
      return AlertDialog(
          title: Text('Input Destination Station'),
          content: Text("loading...",style: Theme.of(context).textTheme.bodyMedium,));
    }


   ;
  }
}