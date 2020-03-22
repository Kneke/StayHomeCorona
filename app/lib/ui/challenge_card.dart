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
    return Card(
      child: Container(
        width: 120,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/jasmin-sessler-egqR_zUd4NI-unsplash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
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
                  onPressed: () {
                    /* ... */
                  },
                ),
                FlatButton(
                  child: const Text('LISTEN'),
                  onPressed: () {
                    /* ... */
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
