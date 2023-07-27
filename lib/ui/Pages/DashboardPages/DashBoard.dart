import "package:flutter/material.dart";
import 'package:login_flutter/ui/Pages/TrainPages/TrainPage.dart';
import "package:login_flutter/ui/Theme/LightColor.dart";
import "package:login_flutter/ui/Components/Header.dart";
import "package:login_flutter/ui/Components/CircularContainer.dart";


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<String> _headers =[
    "Train",
    "Booking",
  ];

  final List<IconData> _icons =[
    Icons.train,
    Icons.credit_card_sharp
  ];

  final List<Widget> _pages = [
    TrainPage(),
    Container(
      child: Center(
        child:Text("hello akash",style: TextStyle(fontSize: 15,color: Colors.black)),

      ),
    )
  ];

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(

        icon: Icon(icon),
        label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.black,
          currentIndex: _currentIndex,
          unselectedItemColor: LightColor.lightGrey,
          type:BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: [
            _bottomIcons(Icons.train),
            _bottomIcons(Icons.credit_card_sharp),
            _bottomIcons(Icons.navigation),
            _bottomIcons(Icons.schedule),
            _bottomIcons(Icons.person),

          ],
          onTap: (index){
              setState(() {
                _currentIndex=index;
              });
          },

        ),

      body: SingleChildScrollView(

        child:Container(
          child:Column(
            children: <Widget>[
              Header(_icons[_currentIndex], _headers[_currentIndex], CircularConatiner(100, Colors.white), LightColor.darkOrange),
              _pages[_currentIndex]
            ],
          )
        )
      ),
    );
  }
}
