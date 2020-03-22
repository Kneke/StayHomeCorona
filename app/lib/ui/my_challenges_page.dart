import 'package:app/model/challenge.dart';
import 'package:app/ui/challenge_card.dart';
import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyChallengesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyChallengesPageState();
}

class _MyChallengesPageState extends State<MyChallengesPage> {
  _MyChallengesPageState() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Challenge>>(
      future: _loadChallenges(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Challenge>> snapshot) {
        List<Widget> children;

        var partitionedChallenges = partition(snapshot.data, 3);

        if (snapshot.hasData) {
          children = <Widget>[

            getHeaderRow('Daily Challenges'),
            ...partitionedChallenges
                .map((challenges) =>
                    Row(children: buildDailyChallengeList(challenges)))
                .toList(),
            getHeaderRow('Challenge accepted! 💪'),
            ...partitionedChallenges
                .map((challenges) =>
                    Row(children: buildDailyChallengeList(challenges)))
                .toList(),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            // TODO
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          // TODO
          children = <Widget>[
//            SizedBox(
//              child: CircularProgressIndicator(),
//              width: 60,
//              height: 60,
//            ),
//            const Padding(
//              padding: EdgeInsets.only(top: 16),
//              child: Text('Lade Challenges...'),
//            )
          ];
        }
//        return Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: children,
//          ),
//        );
        return SingleChildScrollView(child: Column(children: children));
      },
    );
  }

  List<ChallengeCard> buildDailyChallengeList(List<Challenge> challenges) {
    return challenges
        .map<ChallengeCard>((challenge) => ChallengeCard(challenge: challenge))
        .toList();
  }

  Row getHeaderRow(String text) => Row(children: [
        Text(text,
            style: TextStyle(
              height: 1.5,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ))
      ]);
}

List<List<T>> partition<T>(List<T> list, int size) {
  if (list == null) {
    return [];
  }
  return list.fold([<List<T>>[], 0], (prev, element) {
    var count = prev[1];
    List<List<T>> nextAcc = prev[0];
    if (count % size == 0) {
      nextAcc.add(<T>[element]);
    } else {
      nextAcc.last.add(element);
    }
    return [nextAcc, count + 1];
  })[0];
}

//Future<List<Challenge>> _loadChallenges() async {
//  var url = 'http://52.59.253.61:8080/v1/challenges';
//
//  var response = await http.get(url);
////  var response = {'body': await _response, 'statusCode': 200};
//  if (response.statusCode == 200) {
//    List<Challenge> challenges = convert.json
//        .decode(response.body)['values']
//        .map<Challenge>((c) => Challenge.fromJson(c))
//        .toList();
//    print('Loaded ${challenges.length} challenges.');
//    return challenges;
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
//}

/// Mock
Future<List<Challenge>> _loadChallenges() async {
  var url = 'http://52.59.253.61:8080/v1/challenges';

//  var response = await http.get(url);
  var response = {'body': await _response, 'statusCode': 200};
//  if (response.statusCode == 200) {
  List<Challenge> challenges = convert.json
      .decode(response['body'])['values']
      .map<Challenge>((c) => Challenge.fromJson(c))
      .toList();
  print('Loaded ${challenges.length} challenges.');
  return challenges;
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
}

Future<String> _response = Future<String>.delayed(
  Duration(seconds: 2),
  () =>
      '{ "values": [{ "id": 1, "title": "Fairness fordern", "duration": "12h ",  "points": 25 }, { "id": 2, "title": "Aufgeschobenes erledigen", "points": 10 }, { "id": 3, "title": "Körperliche Betätigung", "points": 10 }] }',
);
