class Profile {
  String? userName;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;

  Profile(
      {this.userName, this.email, this.phone, this.firstName, this.lastName});

  Profile.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}