import 'package:flutter/material.dart';
import 'package:login_flutter/ui/Theme/LightColor.dart';
import 'package:login_flutter/ui/Components/RecommendedPage.dart';
import 'package:login_flutter/ui/Components/QuadClipper.dart';
import 'package:login_flutter/ui/Components/Header.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: LightColor.black.withAlpha(40))
        ],
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(
      String title,
      Color primary,
      Color textColor,
      double fontsize,
      BuildContext context
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width:MediaQuery.of(context).size.width -40,
            height:50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: LightColor.grey.withAlpha(40),
            ),
            child:Center(
              child: Text(
                title,
                style: TextStyle(
                    color: LightColor.black, fontWeight: FontWeight.bold,fontSize:fontsize ),
              ),
            )

          )

        ],
      ),
    );
  }


  //category 1
  Widget _featuredRowA(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _card(context,
                primary: LightColor.background,
                backWidget:
                _decorationContainerA(LightColor.lightOrange, 50, -30),
                chipColor: LightColor.darkOrange,
                chipText1: "Find the right degree for you",
                chipText2: "ADD",
                isPrimaryCard: false,
                imgPath:
                "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerB(Colors.white, 90, -40),
                chipText1: "Become a data scientist",
                chipText2: "ADD",
                imgPath:
                "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerC(Colors.white, 50, -30),
                chipText1: "Become a digital marketer",
                chipText2: "ADD",
                imgPath:
                "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerD(LightColor.seeBlue, -50, 30,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.darkseeBlue),
                chipText1: "Become a machine learner",
                chipText2: "ADD",
                imgPath:
                "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
          ],
        ),
      ),
    );
  }

  //category 2
  Widget _featuredRowB(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _card(context,
                primary: LightColor.background,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerD(
                    LightColor.lightGrey, -100, -65,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.seeBlue),
                chipText1: "English for career development ",
                chipText2: "8 Cources",
                isPrimaryCard: false,
                imgPath:
                "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerE(
                  LightColor.lightpurple,
                  90,
                  -40,
                  secondary: LightColor.lightseeBlue,
                ),
                chipText1: "Bussiness foundation",
                chipText2: "8 Cources",
                imgPath:
                "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerF(
                    LightColor.lightOrange, LightColor.orange, 50, -30),
                chipText1: "Excel skill for business",
                chipText2: "8 Cources",
                imgPath:
                "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
            _card(context,
                primary: Colors.white,
                chipColor: LightColor.darkOrange,
                backWidget: _decorationContainerA(
                  Colors.white,
                  -50,
                  30,
                ),
                chipText1: "Beacame a data analyst",
                chipText2: "8 Cources",
                imgPath:
                "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
          ],
        ),
      ),
    );
  }

  //cards that screening the trains
  Widget _card(BuildContext context,
      {Color primary = Colors.redAccent,
        String? imgPath,
        String chipText1 = '',
        String chipText2 = '',
        Widget? backWidget,
        Color chipColor = LightColor.orange,
        bool isPrimaryCard = false}) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  color: LightColor.darkBlue.withAlpha(40))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[


                Positioned(
                  bottom: 10,
                  left: 10,
                  child: _cardInfo(context, chipText1, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  //card body information
  Widget _cardInfo(BuildContext context, String title, String courses,
      Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right:10),
            width: 100,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isPrimaryCard ? Colors.white : textColor,
              ),
            ),
          ),
          SizedBox(height: 8),
          _chip(courses, primary, height: 10, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  //card bottom button
  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {Color? secondary, Color? secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {Color? secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

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
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: 0,
        items: [
          _bottomIcons(Icons.train),
          _bottomIcons(Icons.credit_card_sharp),
          _bottomIcons(Icons.navigation),
          _bottomIcons(Icons.schedule),
          _bottomIcons(Icons.person),
        ],
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RecomendedPage(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Header(Icons.train, "trains", _circularContainer(100, Colors.white), LightColor.darkOrange),
              SizedBox(height: 20),
              _categoryRow("Available Trains", LightColor.orange, LightColor.orange,15,context),
              _featuredRowA(context),
              SizedBox(height: 0),
              _categoryRow(
                  "Delayed Trains", LightColor.lightblack, LightColor.darkpurple,15,context),
              _featuredRowB(context)
            ],
          ),
        ),
      ),
    );
  }
}
