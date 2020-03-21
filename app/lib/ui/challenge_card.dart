import 'package:app/model/challenge.dart';
import 'package:flutter/material.dart';
class ChallengeState extends State<ChallengeCard> {
  Challenge _challenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('Achievements')
      ),
    );
  }}

class ChallengeCard extends StatefulWidget {
  @override
  ChallengeState createState() => ChallengeState();
}