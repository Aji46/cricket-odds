import 'dart:convert';

import 'package:cricket_odds/model/Match_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'match_detailes.dart';

class LiveScorePage extends StatefulWidget {
  @override
  _LiveScorePageState createState() => _LiveScorePageState();
}

class _LiveScorePageState extends State<LiveScorePage> {
  List<CricketApiResponse> liveMatches = [];
  bool isLoading = true;
  String errorMessage = '';

    List<double> homeTeamScores = [];
  List<double> awayTeamScores = [];


  @override
  void initState() {
    super.initState();
    fetchLiveMatches();
  }

  Future<void> fetchLiveMatches() async {
    const String bearerToken = 'ndyMIUaDrEShEcQZwgH5fw';
    const String apiUrl = 'https://cricket.sportdevs.com/matches-live';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          liveMatches = data.map((json) => CricketApiResponse.fromJson(json)).toList();
          isLoading = false;
        });

           liveMatches.forEach((match) {
          homeTeamScores.add(match.homeTeamScore.display.toDouble());
          awayTeamScores.add(match.awayTeamScore.display.toDouble());
        });
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching matches. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Cricket Scores'),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage, style: TextStyle(color: Colors.red)),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: fetchLiveMatches,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : liveMatches.isEmpty
                  ? Center(child: Text('No live matches available'))
                  : ListView.builder(
                      itemCount: liveMatches.length,
                      itemBuilder: (context, index) {
                        final match = liveMatches[index];
                        return MatchCard(match: match);
                      },
                    ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final CricketApiResponse match;

  MatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
  child: InkWell(
               onTap: () {
           
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComparisonPage(
                   homeTeamScores: match.homeTeamScore.display.toDouble(),
                   awayTeamScores: match.awayTeamScore.display.toDouble(),
                   team1:match.homeTeamName,
                   team2:match.awayTeamName,
 
                  ),
                ),
              );
            },

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Text(
                  match.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${match.tournamentName} - ${match.seasonName}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: const Color.fromARGB(255, 0, 119, 255),
                  ),
                ),
                const SizedBox(height: 10),

                // Teams and Scores
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TeamInfo(
                        teamName: match.homeTeamName,
                        teamScore: match.homeTeamScore.display.toString(),
                        teamImage: 'https://cricket.sportdevs.com/matches-live/${match.homeTeamHashImage}',
                      ),
                    ),
                    const Text(
                      'vs',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: TeamInfo(
                        teamName: match.awayTeamName,
                        teamScore: match.awayTeamScore.display.toString(),
                        teamImage: match.awayTeamHashImage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Live Match Status
                Text(
                  'Status: ${match.status.type} - ${match.status.reason}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),

            
                TradingValuesSection(),
                const SizedBox(height: 10),

                MatchUpdatesSection(),
                const SizedBox(height: 10),

             
                Text(
                  'Start Time: ${DateFormat.yMMMd().add_jm().format(match.startTime)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'End Time: ${DateFormat.yMMMd().add_jm().format(match.endTime)}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )
        );
      },
    );
  }
}

class TeamInfo extends StatelessWidget {
  final String teamName;
  final String teamScore;
  final String teamImage;

  const TeamInfo({
    required this.teamName,
    required this.teamScore,
    required this.teamImage,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(teamImage),
          radius: screenWidth * 0.05, 
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamName,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                teamScore,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: const Color.fromARGB(255, 0, 115, 255),
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class TradingValuesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trading Values:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTradingItem('Match Winner', '1.85'),
            _buildTradingItem('Total Runs', '120.5'),
          ],
        ),
      ],
    );
  }

  Widget _buildTradingItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}

class MatchUpdatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Match Updates:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            _buildUpdateItem('Wicket', Colors.red),
            const SizedBox(width: 10),
            _buildUpdateItem('Six', Colors.green),
            const SizedBox(width: 10),
            _buildUpdateItem('Four', Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildUpdateItem(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
