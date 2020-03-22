import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.blue;
    Color labelColor = Colors.black;

    Widget starSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStarsRow(
              iconColor, Icons.star, labelColor, 'Soziale \n Kartoffel'),
          _buildStarsRow(
              Colors.grey, Icons.star, labelColor, 'Sozialer \n Aufsteiger'),
          _buildStarsRow(
              Colors.grey, Icons.star, labelColor, 'Sozialer \n Netzwerker'),
          _buildStarsRow(
              Colors.grey, Icons.star, labelColor, 'Sozialer \n Held'),
        ],
      ),
    );

    Widget userSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildUserRow1("Max Mustermann", "Stuttgart", "🥔 Couch Potato"),
          _buildUserRow2("55", "5", "4", "10"),
        ],
      ),
    );

    Widget achievementSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAchievementsRow(Colors.black, "5", "Quarantäne Tage"),
          _buildAchievementsRow(Colors.black, "40", "Gerettete Personen"),
        ],
      ),
    );

    Widget achievementTitleSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _achievementsTitleRow(),
        ],
      ),
    );

    return ListView(
      children: <Widget>[
        Container(
            height: 40,
            child: Center(
                child: Text(
              "Erfolge",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ))),
        Container(
          height: 200,
          child: Center(child: userSection),
        ),
        Container(
          height: 100,
          child: Center(child: starSection),
        ),
        Container(
          height: 60,
          child: Center(child: achievementTitleSection),
        ),
        Container(
          height: 140,
          child: Center(child: achievementSection),
        ),
      ],
    );
  }
}

Column _buildStarsRow(
    Color iconColor, IconData icon, Color labelColor, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: labelColor,
          ),
        ),
      ),
    ],
  );
}

Column _achievementsTitleRow() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Du hast folgendes erreicht:",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Column _buildAchievementsRow(
    Color labelColor, String labeldays, String labelSavedPersons) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            labeldays,
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: labelColor,
            ),
          )),
      Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            labelSavedPersons,
            style: TextStyle(
              fontSize: 20,
              color: labelColor,
            ),
          )),
    ],
  );
}

Column _buildUserRow1(String name, String location, String status) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        child: Icon(Icons.person, size: 75),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          "📍" +location,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}

Column _buildUserRow2(String points, String challengesNr,
    String sharedChallenges, String friendsNr) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        width: 200.0,
        height: 32.0,
        alignment: Alignment.centerRight,
        child: Text("Punkte: 🔥" + points,
            style: new TextStyle(
                color: Colors.white)),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
            color: Colors.black),
        padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        width: 200.0,
        height: 32.0,
        alignment: Alignment.centerRight,
        child: Text("Erledigte Challenges: 💪" + challengesNr,
            style: new TextStyle(
                color: Colors.white)),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
            color: Colors.amber[900]),
        padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        width: 200.0,
        height: 32.0,
        alignment: Alignment.centerRight,
        child: Text("Geteilte Inhalte: 🤳" + sharedChallenges,
            style: new TextStyle(
                color: Colors.white)),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
            color: Colors.purpleAccent),
        padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      ),
      Container(
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        width: 200.0,
        height: 32.0,
        alignment: Alignment.centerRight,
        child: Text("Challenge Freunde: 😎" + friendsNr,
            style: new TextStyle(
                color: Colors.white)),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(new Radius.circular(90.0)),
            color: Colors.cyan[200]),
        padding: new EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      ),
    ],
  );
}
