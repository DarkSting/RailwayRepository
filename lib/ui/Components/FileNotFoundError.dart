import 'package:flutter/material.dart';
import 'package:login_flutter/ui/Pages/DashboardPages/DashBoard.dart';

class ReusablePrimaryButton extends StatelessWidget {
  const ReusablePrimaryButton({
    Key? key,
    required this.childText,
    required this.onPressed,
    required this.buttonColor,
    required this.childTextColor,
  }) : super(key: key);

  final String childText;
  final Function onPressed;
  final Color buttonColor;
  final Color childTextColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed as VoidCallback,
      child:Container(
         height: 40,
         width: 200,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           color: buttonColor,
         ),
         child: Center(
             child: Text(
               childText.toUpperCase(),
               style: TextStyle(
                 fontSize: 16,
                 color: childTextColor,
                 fontWeight: FontWeight.w600,
               ),
             )),
       ),

    );
  }
}

const kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 25,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

const kSubtitleTextStyle = TextStyle(
  color: Colors.black38,
  fontSize: 16,
  letterSpacing: 1,
  fontWeight: FontWeight.w500,
);

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            bottom: 260,
            left: 100,
            child: Text(
              'Page Not Found',
              style: kTitleTextStyle,
            ),
          ),
          const Positioned(
            bottom: 190,
            left: 50,
            child: Text(
              'Oops! The page you are looking for\nis not found.',
              style: kSubtitleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom:100,
            left: 80,
            child: ReusablePrimaryButton(
              childText: 'Go Back to Home',
              buttonColor: Colors.green,
              childTextColor: Colors.white,
              onPressed: () {
                print("hello");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=> Dashboard())
                );


  
              },
            ),
          ),
        ],
      ),
    );
  }
}