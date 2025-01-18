import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ComparisonPage extends StatelessWidget {
  final double homeTeamScores;
  final double awayTeamScores;
  final String team1;
  final String team2;

  const ComparisonPage({
    Key? key,
    required this.homeTeamScores,
    required this.awayTeamScores,
    required this.team1,
    required this.team2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Analysis'),
      ),
      body: PieChart(
        dataMap: {
          team1: homeTeamScores,
          team2: awayTeamScores,
        },
        chartType: ChartType.ring,
      ),
    );
  }
}
