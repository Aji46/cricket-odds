
import 'package:cricket_odds/view/homescreen.dart';
import 'package:cricket_odds/view/widgets/SecondaryFeture.dart';
import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SecondaryFeatureHomeScreen(
          color1: Colors.green,
          icon: const Icon(Icons.groups_sharp, color: Colors.white),
          text: 'Match',
          page: HomeScreen(),
        ),
        SecondaryFeatureHomeScreen(
          color1: Colors.blue,
          icon: const Icon(Icons.bookmark, color: Colors.white),
          text: 'Teams',
          page: HomeScreen(),
        ),
        SecondaryFeatureHomeScreen(
          color1: Colors.purple,
          icon: const Icon(Icons.smart_toy, color: Colors.white),
          text: 'Winning Rate',
          page: HomeScreen(),
        ),
      ],
    );
  }
}