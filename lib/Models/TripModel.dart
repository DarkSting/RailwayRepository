import "dart:convert";
import "package:http/http.dart" as http;
import "package:login_flutter/Models/RouteModel.dart";

class TripModel {
  String? duration;
  String? train;
  String? departure;
  String? arrival;
  String? route;
  String? bookingOpeningExpired;
  RouteModel? routeData;

  TripModel(
      {this.duration,
        this.train,
        this.departure,
        this.arrival,
        this.route,
        this.bookingOpeningExpired});

  TripModel.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    train = json['train'];
    departure = json['departure'];
    arrival = json['arrival'];
    route = json['route'];
    bookingOpeningExpired = json['bookingOpeningExpired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['train'] = this.train;
    data['departure'] = this.departure;
    data['arrival'] = this.arrival;
    data['route'] = this.route;
    data['bookingOpeningExpired'] = this.bookingOpeningExpired;
    return data;
  }

  Future<void> getRouteData() async {
    try {
      final headers = {
        'Content-Type': 'application/json'
      };

      final routeBody = {
        'routeNumber': route
      };

      http.Response response = await http.post(
          Uri.parse("http://192.168.8.114:8080/route/getroute"),
          headers: headers, body: jsonEncode(routeBody));

      if (response.statusCode == 200) {
        this.routeData = RouteModel.fromJson(jsonDecode(response.body)['data']);
        print(this.routeData!.startPoint);
      }
    }
    catch (e) {
      throw Exception(e);
    }
  }

}