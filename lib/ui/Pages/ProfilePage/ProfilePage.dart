import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatelessWidget {

  Future<String> getStoredCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt') ?? '';
  }

  Future<void> sendRequestWithCookies() async {
    try{

      String storedCookies = await getStoredCookies();
      final url = 'https://example.com/api/some_endpoint';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Cookie': storedCookies,
        },
      );

      if(response.statusCode==200){


      }
    }catch(er){
      throw Exception(er);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/train1.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile Number'),
                ),
                SizedBox(height: 12.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
