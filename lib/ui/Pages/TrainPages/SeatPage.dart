import 'package:flutter/material.dart';
import 'package:login_flutter/Models/TrainBookingModel.dart';
import 'package:login_flutter/ui/Pages/BookingPages/TrainBookingPage.dart';

import '../../Components/CircularContainer.dart';
import '../../Theme/LightColor.dart';

class SeatCard extends StatelessWidget {

  final String imageUrl;
  final NetworkImage? networkImage;
  final String context;
  final Color primaryColor;
  final Color buttonColor;
  final Widget? backWidget;
  final String chipText1;
  final String chipText2;


  const SeatCard({super.key,this.imageUrl="",
    this.networkImage,this.buttonColor=Colors.white,
    this.primaryColor = Colors.blue,this.backWidget,this.chipText1="test",this.chipText2="test2",
    this.context="hello",
  });

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
        width:  width,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 5,
                  color: LightColor.black.withAlpha(40))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                //add card items here
                _cardInfo(context, chipText1, chipText2,
                    LightColor.titleTextColor, chipColor,
                    isPrimaryCard: isPrimaryCard),

              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(BuildContext context, String title, String courses,
      Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(

            width: 100,
            alignment: Alignment.centerRight,
            child: imageUrl!=""? Image.asset(imageUrl):Center(child: Text("Image not Available"),),
          ),
          SizedBox(height: 5),
          Container(
            height: 70,
            margin: EdgeInsets.only(left: 80),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white,
                  backgroundColor: LightColor.darkBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return  TrainBookingPage(trainData: TrainBooking(seatPrice: 200,trainNumber: 200,passengers: 6,seatType: "A1"));
                    },
                  ),
                );
              },
              child: Text(courses),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.centerLeft,
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children:<Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
                color: LightColor.lightOrange,
                borderRadius: BorderRadius.only(bottomRight:Radius.circular(50),bottomLeft:Radius.circular(50) )
            ),
            child:Center(
              child: Text(
                "Available Seats",
                style: TextStyle(fontSize:40,color: Colors.white
                ),

              ),
            ),
          ),
          Column(
            children: <Widget>[
              _card(context,primary: LightColor.background,chipText1: "Book Seat",chipText2:"Book Seat", )
            ],
          )
        ],
      ),

    );
    //
    //   _card(context,
    //   primary: primaryColor,
    //   imgPath: importedImage?.assetName,
    //   chipText1: chipText1,
    //   chipText2: chipText2,
    //   backWidget: backWidget,
    //   chipColor: buttonColor,
    // );
  }
}

