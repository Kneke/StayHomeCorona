import 'package:app/model/challenge.dart';
import 'package:flutter/material.dart';

class ChallengeDetailPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Challenge challenge = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              constraints: BoxConstraints.expand(
                height: 250.0,
              ),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20, bottom: 50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/challenge_detail_image.jpg'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: new Text(challenge.title,
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0))),
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
              challenge.description,
              softWrap: true,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 180, left: 30, right: 30),
            child: OutlineButton(
              child: Text('Challenge einen Freund'),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: RaisedButton(
              color: Colors.black,
              child: Text(
                'Challenge absolvieren',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
