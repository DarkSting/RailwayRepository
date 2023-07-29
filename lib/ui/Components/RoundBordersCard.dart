import "package:flutter/material.dart";

import "../Theme/LightColor.dart";


class RoundBordersCard extends StatefulWidget {

  final AssetImage? importedImage;
  final NetworkImage? networkImage;
  final String context;
  final Color primaryColor;
  final Color buttonColor;
  final Widget? backWidget;
  final String chipText1;
  final String chipText2;


  const RoundBordersCard({super.key,this.importedImage,
    this.networkImage,this.buttonColor=Colors.white,
    this.primaryColor = Colors.blue,this.backWidget,this.chipText1="test",this.chipText2="test2",
    this.context="hello"
  });

  @override
  State<RoundBordersCard> createState() => _RoundBordersCardState();
}

class _RoundBordersCardState extends State<RoundBordersCard> {

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right:10),
            width: 100,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isPrimaryCard ? Colors.white : textColor,
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(

            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white,
                  backgroundColor: LightColor.darkBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              onPressed: (){
                print("im clicked");
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
    return _card(context,
      primary: widget.primaryColor,
      imgPath: widget.importedImage?.assetName,
      chipText1: widget.chipText1,
      chipText2: widget.chipText2,
      backWidget: widget.backWidget,
      chipColor: widget.buttonColor,
    );
  }
}
