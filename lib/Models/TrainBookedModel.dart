import 'dart:math' as Math;

class BookedModel {
  bool? isPaid;
  List<String>? bookedSeats;
  int? totalPrice;
  String? bookedDate;

  BookedModel(
      {this.isPaid, this.bookedSeats, this.totalPrice, this.bookedDate});

  BookedModel.fromJson(Map<String, dynamic> json) {
    isPaid = json['isPaid'];

    if (json['bookedSeats'] != null) {
      bookedSeats = <String>[];
      json['bookedSeats'].forEach((v) {
        bookedSeats!.add(v);
      });
    }
    totalPrice = (json['totalPrice']/100).toInt()*2;
    bookedDate = json['bookedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPaid'] = this.isPaid;
    if (this.bookedSeats != null) {
      data['bookedSeats'] = this.bookedSeats?.map((v) => v).toList();
    }
    data['totalPrice'] = this.totalPrice;
    data['bookedDate'] = this.bookedDate;
    return data;
  }
}