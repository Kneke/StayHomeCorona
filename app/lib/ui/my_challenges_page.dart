import 'package:app/ui/challenge_detail_page.dart';
import 'package:flutter/material.dart';

class MyChallengesPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
              child: Text("Challenge Detail"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChallengeDetailPage()));
              },
          ),
      ),
    );
  }
}