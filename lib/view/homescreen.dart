

import 'dart:async';

import 'package:cricket_odds/Controller/Cricket_services.dart';
import 'package:cricket_odds/model/Match_list.dart';
import 'package:cricket_odds/view/featured_section.dart';
import 'package:cricket_odds/view/header.dart';
import 'package:cricket_odds/view/live_matched.dart';
import 'package:cricket_odds/view/widgets/CustomScafold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CricketService _cricketService = CricketService();
  List<CricketApiResponse> liveMatches = [];
  bool isLoading = true;
  String errorMessage = '';
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    fetchLiveMatches();
    _pollingTimer = Timer.periodic(Duration(seconds: 30), (_) => fetchLiveMatches());
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchLiveMatches() async {
    try {
      final matches = await _cricketService.fetchLiveMatches();
      setState(() {
        liveMatches = matches;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching matches. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            HeaderSection(),
            const SizedBox(height: 50),
            FeaturesSection(),
            const SizedBox(height: 20),
            LiveMatchesSection(
              isLoading: isLoading,
              errorMessage: errorMessage,
              liveMatches: liveMatches,
              onRetry: fetchLiveMatches,
            ),
          ],
        ),
      ),
    );
  }
}
