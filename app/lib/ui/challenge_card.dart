import 'package:app/model/challenge.dart';
import 'package:app/ui/challenge_detail_page.dart';
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
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: RouteSettings(arguments: this.widget.challenge),
                      builder: (context) => ChallengeDetailPage()));
            },
            child: Stack(children: <Widget>[
              Container(
                height: 140,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "lib/assets/jasmin-sessler-egqR_zUd4NI-unsplash.jpg"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.transparent,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent]),
                    backgroundBlendMode: BlendMode.plus),
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent.withOpacity(0.0)
                        ])),
              ),
              Container(
                height: 140,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.challenge.title,
                        style: TextStyle(
                            height: 1.3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                      Column(
                        children: <Widget>[
                          Center(child: getDurationChip()),
                          Center(child: getFlameChip())
                        ],
                      )
                    ]),
              )
            ])));
  }

  Chip getDurationChip() {
    return Chip(
      avatar: Icon(
        Icons.timer,
        size: 12,
      ),
      label: Text(
        widget.challenge.duration ?? "1 T",
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  Chip getFlameChip() {
    int points = widget.challenge.points;
    var pointPossibilities = [5, 10, 25, 50];
    int numFlames = pointPossibilities.indexOf(points) + 1;

    return Chip(
      backgroundColor: Colors.black,
      label: Text('🔥' * (numFlames != 0 ? numFlames : 1) + ' +$points',
          style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
