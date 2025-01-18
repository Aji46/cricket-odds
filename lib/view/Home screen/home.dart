// import 'dart:async';
// import 'dart:convert';

// import 'package:cricket_odds/model/Match_list.dart';
// import 'package:cricket_odds/view/Home%20screen/widgets/CustomScafold.dart';
// import 'package:cricket_odds/view/Home%20screen/widgets/SecondaryFeture.dart';
// import 'package:cricket_odds/view/Home%20screen/widgets/live_score.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_fadein/flutter_fadein.dart';
// import 'package:http/http.dart' as http;


// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<CricketApiResponse> liveMatches = [];
//   bool isLoading = true;
//   String errorMessage = '';

//    Timer? _pollingTimer;

//   @override
//   void initState() {
//     super.initState();
//     fetchLiveMatches();

//     // Poll every 30 seconds
//     _pollingTimer = Timer.periodic(Duration(seconds: 30), (timer) {
//       fetchLiveMatches();
//     });
//   }

//   @override
//   void dispose() {
//     _pollingTimer?.cancel();
//     super.dispose();
//   }
//   Future<void> fetchLiveMatches() async {
//     const String bearerToken = 'TYziU7-Y3EmrbKog7GUj5g';
//     const String apiUrl = 'https://cricket.sportdevs.com/matches-live';

//     try {
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $bearerToken',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           liveMatches = data.map((json) => CricketApiResponse.fromJson(json)).toList();
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load matches');
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'Error fetching matches. Please try again.';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 30),
//             // Fade in the header
//             FadeIn(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Manage Your",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.format_list_numbered_sharp,
//                             color: Colors.green,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Navigate to Notifications
//                           },
//                           icon: const Icon(
//                             Icons.notification_important_rounded,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),

//             // Secondary Features Section
//  Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     SecondaryFeatureHomeScreen(
//       color1: Colors.green,
//       icon: const Icon(
//         Icons.groups_sharp,
//         color: Colors.white,
//       ),
//       text: 'Match',
//       page: MatchPage(),
//     ),
//     SecondaryFeatureHomeScreen(
//       color1: Colors.blue,
//       icon: const Icon(
//         Icons.bookmark,
//         color: Colors.white,
//       ),
//       text: 'Teams',
//       page: TeamsPage(),
//     ),
//     SecondaryFeatureHomeScreen(
//       color1: Colors.purple,
//       icon: const Icon(
//         Icons.smart_toy,
//         color: Colors.white,
//       ),
//       text: 'Winning Rate',
//       page: WinningRatePage(),
//     ),
//   ],
// ),

//             const SizedBox(height: 20),

//             // Live Matches Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Live Matches',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white70,
//                 ),
//               ),
//             ),
//             isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : errorMessage.isNotEmpty
//                     ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               errorMessage,
//                               style: TextStyle(color: Colors.red),
//                             ),
//                             SizedBox(height: 10),
//                             ElevatedButton(
//                               onPressed: fetchLiveMatches,
//                               child: Text('Retry'),
//                             ),
//                           ],
//                         ),
//                       )
//                     : liveMatches.isEmpty
//                         ? Center(
//                             child: Text(
//                               'No live matches available',
//                               style: TextStyle(color: Colors.white70),
//                             ),
//                           )
//                         : ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: liveMatches.length,
//                             itemBuilder: (context, index) {
//                               final match = liveMatches[index];
//                               return MatchCard(match: match);
//                             },
//                           ),
//           ],
//         ),
//       ),
//     );
//   }
// }
