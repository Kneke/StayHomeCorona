import 'package:app/model/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatefulWidget {
  ChallengeCard({this.challenge});

  Challenge challenge;

  @override
  ChallengeCardState createState() => ChallengeCardState();
}

class ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album),
              title: Text(widget.challenge.title),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Challenge annehmen'),
                  onPressed: () { /* ... */ },
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
