class Profile {
  String? name;
  String? email;
  String? phone;
  String? dOB;
  String? userName;

  Profile({this.name, this.email, this.phone, this.dOB, this.userName});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    dOB = json['DOB'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['DOB'] = this.dOB;
    data['userName'] = this.userName;
    return data;
  }
}