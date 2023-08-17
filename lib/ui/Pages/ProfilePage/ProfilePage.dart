import 'dart:convert';
import 'package:login_flutter/Models/ProfileDetails.dart';
import 'package:flutter/material.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Components/Spinners.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  Profile? currentUser;
  bool isLoading = true;

  @override
  initState(){
    super.initState();
    sendRequestWithCookies().then((value){
      isLoading = false;
    }).catchError((onError){
      isLoading = false;
    });
  }
  Future<String> getStoredCookies() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt') ?? '';

  }

  Future<void> sendRequestWithCookies() async {
    try{

      String storedCookies = await getStoredCookies();

      final url = 'http://192.168.8.114:8080/user/getuser';

      final body ={
        'userID' : storedCookies
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type':'application/json'
        },
        body:jsonEncode(body)
      );

      if(response.statusCode==200){
        setState(() {
          currentUser = Profile.fromJson(jsonDecode(response.body));
        });
      }
    }catch(er){
      throw Exception(er);
    }

  }

  @override
  Widget build(BuildContext context) {

    if(!isLoading && currentUser!=null){
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
                color: LightColor.grey,
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
                    decoration: InputDecoration(labelText: currentUser?.name),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: currentUser?.userName),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: currentUser?.phone),
                  ),
                  SizedBox(height: 12.0),
                  TextFormField(
                    decoration: InputDecoration(labelText: currentUser?.email),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    else if(!isLoading && currentUser!=null){
      return Container(
        child: Center(
          child: Text('No available bookings',style: Theme.of(context).textTheme.bodyMedium,),
        ),
      );
    }

      return Expanded(child: Spinner());


  }
}

