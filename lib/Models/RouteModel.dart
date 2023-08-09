class RouteModel {
  List<String>? stops;
  bool? isClosed;
  String? routeNumber;
  String? startPoint;
  String? endPoint;

  RouteModel(
      {this.stops,
        this.isClosed,
        this.routeNumber,
        this.startPoint,
        this.endPoint});

  RouteModel.fromJson(Map<String, dynamic> json) {
    if (json['Stops'] != null) {
      stops = <String>[];
      json['Stops'].forEach((v) {

        if(v!=null){
          stops!.add(v.toString());
        }

      });


    }
    isClosed = json['isClosed'];
    routeNumber = json['routeNumber'];
    startPoint = json['startPoint'];
    endPoint = json['endPoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['isClosed'] = this.isClosed;
    data['routeNumber'] = this.routeNumber;
    data['startPoint'] = this.startPoint;
    data['endPoint'] = this.endPoint;
    return data;
  }
}