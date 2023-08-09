import 'dart:convert';

class Station{
  String? sId;
  double? longitude;
  double? latitude;
  String? stationClass;
  String? stationNumber;
  String? stationName;

  Station(
      {this.sId,
        this.longitude,
        this.latitude,
        this.stationClass,
        this.stationNumber,
        this.stationName});

  Station.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    longitude = double.tryParse(json['longitude']);
    latitude = double.tryParse(json['latitude']);
    stationClass = json['stationClass'];
    stationNumber = json['stationNumber'];
    stationName = json['stationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['stationClass'] = this.stationClass;
    data['stationNumber'] = this.stationNumber;
    data['stationName'] = this.stationName;

    return data;
  }




}