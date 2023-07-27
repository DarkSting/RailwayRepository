import "package:flutter/material.dart";
import "../Theme/LightColor.dart";

class CircularConatiner extends StatelessWidget {

  final double height;
  final Color color;

  const CircularConatiner(this.height,this.color,{super.key});

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

  @override
  Widget build(BuildContext context) {
    return _circularContainer(this.height, this.color);
  }
}
