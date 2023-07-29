import "package:flutter/material.dart";

import "../Theme/LightColor.dart";

class TopicBar extends StatelessWidget {

    final String title;
    final Color primary;
    final Color textColor;
    final  double fontsize;
    final double height;

  const TopicBar(this.title,this.textColor,this.primary,this.fontsize,this.height,{super.key});

  Widget _categoryRow(
      String title,
      Color primary,
      Color textColor,
      double fontsize,
      BuildContext context,
      double height
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width:MediaQuery.of(context).size.width -40,
              height:50 + height,
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

  @override
  Widget build(BuildContext context) {
    return _categoryRow(title, primary, textColor, fontsize, context,height);
  }
}


