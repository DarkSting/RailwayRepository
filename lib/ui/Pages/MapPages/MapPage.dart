import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:login_flutter/Models/StationModel.dart';
//import 'package:login_flutter/Models/SocketIO.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {

  List<String> stations;
  String origin;
  String destination;

   MapPage({ this.origin="",this.destination="",required this.stations,super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //tracked inserted trainstations
  List<Station> stationList =[];
  Set<Polyline> _polyLines = Set<Polyline>();

  int polyLineID = 1;

  Future<List<Station>> getTrainStations(List<String> stations) async{

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
  //set markers
  Set<Marker> markers = new Set<Marker>();

  //current marker index
  int currentIndex = 0;

  //goople api controller
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  //socket
  //TrainLiveSocket? socket;

  //initialize the markers
  @override
  initState(){

    findStations(widget.stations,origin: widget.origin,destination: widget.destination );
    print("hello");
    print(stationList);
    //socket?.connectToSocket();
  }

  void findStations(List<String> stations,{String origin="",String destination=""}){
    getTrainStations(stations).then((value) {
      print(value.length);
      stationList = value;
      markers = createMarkers();

      if(origin!="" && destination!=""){
        getDirections(origin, destination);
      }

      setState(() {

      });

    }).catchError((onError){
      print("hello"+onError.toString());
    });
  }

  //current marker
  Marker _currentMarker = Marker(markerId: MarkerId('marker_1'),
      position: LatLng(6.9337, 79.8500),
      infoWindow: InfoWindow(title:'current position')
  );

  Marker _lastMarker = Marker(markerId: MarkerId('marker_1'),
      position: LatLng(6.9337, 79.8500),
      infoWindow: InfoWindow(title:'current position')
  );

  //create markers to track the directions
  Set<Marker> createMarkers(){

    //18.5 meters
    Set<Marker> markers = Set<Marker>();

    if(stationList.isNotEmpty==true){
      for(int i=0;i<stationList.length;i++){

        Station currentStation = stationList[i];

        LatLng ctLocation = LatLng(currentStation!.latitude!,currentStation!.longitude!);
        Marker currentMarker = Marker(markerId: MarkerId('${currentStation.stationName} marker'),
            position: ctLocation,
            infoWindow: InfoWindow(title: "${currentStation.stationName} marker")
        );
        markers.add(currentMarker);

      }
    }
    return markers;
  }

  static const CameraPosition _jaffna = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.6667, 80.0000),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _jaffna,
                polylines: _polyLines,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers:markers ,
              ),
            Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {


                  _goToThePosition(markers.elementAt(currentIndex).position);
                  currentIndex++;
                  if(markers.length<=currentIndex){
                    currentIndex=0;
                  }






                // Button click handler
              },
              child: Text('Move To Next Marker'),
            ),
          ),
    ]

     )
    );
  }


  //get the directions of the points
  Future<Map<String, dynamic>> getDirections( String origin, String destination) async {

    final String url ='https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=${dotenv.get('API_KEY',fallback: "")}';

    var response = await http.get(Uri.parse(url));

    print(response.statusCode);

    var json = jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds'] ['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

  return results;

  }

  //set the polilines
  void setPolyline (List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_${polyLineID}';
    polyLineID++;

    _polyLines.add(
        Polyline(
          polylineId: PolylineId(polylineIdVal),
          width: 6,
          color: Colors.purple,
          points: points
              .map((point) => LatLng(point.latitude, point.longitude),
          ).toList(),
        ));

   // Polyline
  }

  //animate the camera
  Future<void> _goToThePosition(LatLng newPosition) async {
    final GoogleMapController controller = await _controller.future;

    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: newPosition,
        zoom: 18.4746,
        tilt: 80.440717697143555,
      bearing: 1.0
    )));

    setState(() {
      _currentMarker = markers.elementAt(currentIndex);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //socket?.disConnect();

  }
}