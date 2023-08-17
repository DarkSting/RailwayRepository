import "package:flutter/material.dart";
import "package:login_flutter/ui/Pages/DashboardPages/BookingPage.dart";
import "package:login_flutter/ui/Pages/MapPages/MapPage.dart";
import "package:login_flutter/ui/Pages/ProfilePage/ProfilePage.dart";
import "package:login_flutter/ui/Pages/SchedulePages/SchedulePage.dart";
import 'package:login_flutter/ui/Pages/TrainPages/TrainPage.dart';
import "package:login_flutter/ui/Pages/TripPage/PendingTripsPage.dart";
import "package:login_flutter/ui/Theme/LightColor.dart";
import "package:login_flutter/ui/Components/Header.dart";
import "package:login_flutter/ui/Components/CircularContainer.dart";
import "package:login_flutter/ui/Components/Spinners.dart";



class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<String> _headers =[
    "Train",
    "Bookings",
    "Schedule",
    "Profile"
  ];

  final List<IconData> _icons =[
    Icons.train,
    Icons.credit_card_sharp,
    Icons.schedule,
    Icons.person
  ];

  final List<Widget> _pages = [
    PendingTripsPage(),
    BookingPage(),
    SchedulePage(),
    ProfilePage(),


  ];

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(

        icon: Icon(icon),
        label: "");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingSpinner();
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.black,
          currentIndex: _currentIndex,
          unselectedItemColor: LightColor.grey,
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: [
            _bottomIcons(Icons.train),
            _bottomIcons(Icons.credit_card_sharp),
            _bottomIcons(Icons.schedule),
            _bottomIcons(Icons.person),


          ],
          onTap: (index){
              setState(() {
                _currentIndex=index;
              });
          },

        ),

      body: Container(

          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Header(_icons[_currentIndex], _headers[_currentIndex], CircularConatiner(100, Colors.white), LightColor.darkOrange),
              _pages[_currentIndex>=_pages.length?0:_currentIndex]
            ],
          )
        )
    );
  }
}
