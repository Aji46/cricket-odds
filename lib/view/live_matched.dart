
import 'package:cricket_odds/model/Match_list.dart';
import 'package:cricket_odds/view/widgets/live_score.dart';
import 'package:flutter/material.dart';

class LiveMatchesSection extends StatelessWidget {
  final bool isLoading;
  final String errorMessage;
  final List<CricketApiResponse> liveMatches;
  final VoidCallback onRetry;

  const LiveMatchesSection({
    Key? key,
    required this.isLoading,
    required this.errorMessage,
    required this.liveMatches,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Live Matches',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
        ),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (errorMessage.isNotEmpty) {
      return _buildErrorWidget();
    }
    if (liveMatches.isEmpty) {
      return Center(
        child: Text(
          'No live matches available',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: liveMatches.length,
      itemBuilder: (context, index) => MatchCard(match: liveMatches[index]),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}