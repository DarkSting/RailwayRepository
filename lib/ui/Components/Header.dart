import "package:flutter/material.dart";


class Header extends StatelessWidget {

  final String title;
  final IconData headerIcon;
  final Widget innerCircle;
  final Color _backgroundColor;

  const Header(this.headerIcon,this.title,this.innerCircle,this._backgroundColor,{super.key});
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 150,
          width: width,
          decoration: BoxDecoration(
            color: _backgroundColor,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[

              Positioned(
                  top: 30,
                  right: 30,
                  child: innerCircle),
              Positioned(
                  top: 55,
                  right: 55,
                  child: Icon(headerIcon,
                  size:50)
              ),

              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(height: 20)

                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
            ],
          )),
    );
  }
}



