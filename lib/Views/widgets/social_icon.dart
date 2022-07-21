import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double radius;
  final double size;

  SocialIcon({this.icon, this.color, this.radius = 30.0, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircleAvatar(
          backgroundColor: color,
          radius: radius,
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          ) //Text
          ),
    );
  }
}
