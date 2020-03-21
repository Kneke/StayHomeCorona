import 'package:app/model/challenge.dart';
import 'package:flutter/material.dart';
class ChallengeCardState extends State<ChallengeCard> {
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
  ChallengeCardState createState() => ChallengeCardState();
}