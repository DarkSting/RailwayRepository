import "package:flutter/material.dart";

import "../Theme/LightColor.dart";


class RoundBordersCard extends StatefulWidget {

  final AssetImage? importedImage;
  final NetworkImage? networkImage;
  final String context;
  final Color primaryColor;
  final Color buttonColor;
  final Widget? backWidget;
  final String TrainID;
  final String chipText2;
  final String TrainName;
  final Function() onPressed;

  const RoundBordersCard({super.key,this.importedImage,
    this.networkImage,this.buttonColor=Colors.white,
    this.primaryColor = Colors.blue,this.backWidget,this.TrainID="test",this.chipText2="test2",
    this.TrainName="",
    this.context="hello",required this.onPressed
  });

  @override
  State<RoundBordersCard> createState() => _RoundBordersCardState();
}

class _RoundBordersCardState extends State<RoundBordersCard> {

  Widget _card(BuildContext context,
      {Color primary = Colors.redAccent,
        String? imgPath,
        String TrainID = '',
        String TrainName ='',
        String chipText2 = '',
        Widget? backWidget,
        required Function onPressed,
        Color chipColor = LightColor.orange,
        bool isPrimaryCard = false}) {
    final width = MediaQuery.of(context).size.width;

    return Container(
        height:200,
        width: width * .40,
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            child: Column(
              children: <Widget>[
              //add card items here
                Image.asset('assets/train1.png',fit: BoxFit.cover,height: 100,width: 100,),
                SizedBox(height: 10,),
              _cardInfo(context, TrainID, chipText2,
                      LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard,TrainName: TrainName,onPressed: onPressed as Function()),

              ],
            ),
          ),
        ));
  }

  //card body
  Widget _cardInfo(BuildContext context, String title, String courses,
      Color textColor, Color primary,
      {bool isPrimaryCard = false,String TrainName="",required Function() onPressed}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(

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
          Text(
            TrainName
            ,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isPrimaryCard ? Colors.white : textColor,
            ),
          ),
          SizedBox(height: 5),
          Container(

            child: OutlinedButton(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white,
                  backgroundColor: LightColor.darkBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              onPressed: onPressed,
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
      TrainID: widget.TrainID,
      chipText2: widget.chipText2,
      backWidget: widget.backWidget,
      chipColor: widget.buttonColor,
      TrainName: widget.TrainName,
      onPressed: widget.onPressed

    );
  }
}
