class ScheduleModel {
  Trip? trip;
  List<Stations>? stations;
  Train? train;

  ScheduleModel({this.trip, this.stations, this.train});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    trip = json['trip'] != null ? new Trip.fromJson(json['trip']) : null;
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
    train = json['train'] != null ? new Train.fromJson(json['train']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trip != null) {
      data['trip'] = this.trip!.toJson();
    }
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    if (this.train != null) {
      data['train'] = this.train!.toJson();
    }
    return data;
  }
}

class Trip {
  List<Null>? bookings;
  String? duration;
  bool? isOpened;
  String? sId;
  String? train;
  String? departure;
  String? arrival;
  String? route;
  String? bookingOpeningExpired;
  String? stationID;


  Trip(
      {
        this.train,
        this.departure,
        this.arrival,
        this.route,
        this.bookingOpeningExpired,
        this.stationID,});

  Trip.fromJson(Map<String, dynamic> json) {

    duration = json['duration'];
    train = json['train'];
    departure = json['departure'];
    arrival = json['arrival'];
    route = json['route'];
    bookingOpeningExpired = json['bookingOpeningExpired'];
    stationID = json['stationID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['train'] = this.train;
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['route'] = this.route;
    data['bookingOpeningExpired'] = this.bookingOpeningExpired;
    data['stationID'] = this.stationID;
    return data;
  }
}

class Stations {
  String? longitude;
  String? latitude;
  String? stationNumber;
  String? stationName;


  Stations(
      {this.longitude,
        this.latitude,
        this.stationNumber,
        this.stationName,});

  Stations.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
    stationNumber = json['stationNumber'];
    stationName = json['stationName'];

}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['stationNumber'] = this.stationNumber;
    data['stationName'] = this.stationName;

    return data;
  }
}


//json
class Train {
  List<String>? trainBoxes;
  int? totalSeats;
  String? name;
  int? trainNumber;


  Train(
      {this.trainBoxes,
        this.totalSeats,
        this.name,
        this.trainNumber,
        });

  Train.fromJson(Map<String, dynamic> json) {
    trainBoxes = json['trainBoxes'].cast<String>();
    totalSeats = json['totalSeats'];
    name = json['name'];
    trainNumber = json['trainNumber'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trainBoxes'] = this.trainBoxes;
    data['totalSeats'] = this.totalSeats;
    data['name'] = this.name;
    data['trainNumber'] = this.trainNumber;

    return data;
  }
}