
import 'dart:convert';

import 'package:cricket_odds/model/Match_list.dart';
import 'package:http/http.dart' as http;

class CricketService {
  static const String _bearerToken = '8HPYhdsX_USnKKEGsiQluQ';
  static const String _apiUrl = 'https://cricket.sportdevs.com/matches-live';

  Future<List<CricketApiResponse>> fetchLiveMatches() async {
    final response = await http.get(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_bearerToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CricketApiResponse.fromJson(json)).toList();
    }
    throw Exception('Failed to load matches');
  }
}