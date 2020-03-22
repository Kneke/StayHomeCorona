import 'dart:convert';
import 'package:app/model/challenge.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'challenge_card.dart';
import 'challenge_detail_page.dart';

const url = 'http://52.59.253.61:8080/v1/challenges';

class AllChallengePage extends StatefulWidget {
  @override
  _AllChallengeState createState() => _AllChallengeState();
}

class _AllChallengeState extends State<AllChallengePage> {
  var allChallenges;

  _loadAllChallenges() async {
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<Challenge> challengeList =
            json.decode(response.body)['values'].map<Challenge>((c) => Challenge.fromJson(c)).toList();
        setState(() {
          allChallenges = challengeList;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return;
      }
    } on Exception catch (e) {
      print('Request failed with error: $e.');
      return;
    }
  }

  _getBody() {
    if (allChallenges == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: <Widget>[
          SizedBox(
              width: double.infinity,
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text('Wähle eine Challenge', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))),
          Expanded(
              child: GridView.count(
            primary: false,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            childAspectRatio: 0.8,
            crossAxisCount: 3,
            children: _getGrindItems(),
          )),
        ],
      );
    }
  }

  _getGrindItems() {
    List<Widget> list = allChallenges.map<Widget>((challenge) =>
        GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChallengeDetailPage()),
              );
            },
          child: ChallengeCard(challenge: challenge)
        )
    ).toList();
    return list;
  }

  @override
  void initState() {
    _loadAllChallenges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }
}
