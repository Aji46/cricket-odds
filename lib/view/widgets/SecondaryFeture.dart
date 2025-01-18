import 'package:flutter/material.dart';

class SecondaryFeatureHomeScreen extends StatelessWidget {
  final MaterialColor color1;
  final String text;
  final Icon icon;
  final Widget page;

  SecondaryFeatureHomeScreen({
    super.key,
    required this.text,
    required this.icon,
    required this.color1,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
          },
          child: Container(
            height: 50,
            width: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, Colors.black],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: icon),
          ),
        ),
        Text(text),
      ],
    );
  }
}

