import 'package:app/model/challenge.dart';
import 'package:flutter/material.dart';


//class DashboardPage extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//          child: Text('Dashboard Page')
//      ),
//    );
//  }
//}

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyChallengesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyChallengesPageState();
}

Future<String> _calculation = Future<String>.delayed(
  Duration(seconds: 2),
      () => 'Data Loaded',
);

Future<String> _response = Future<String>.delayed(
  Duration(seconds: 2),
      () =>
  '{ "values": [{ "id": 1, "title": "Fairness fordern", "points": 25 }] }',
);

Future<List<dynamic>> _loadChallenges() async {
  var url = 'http://10.0.2.2:8080/v1/challenges';

  // Await the http get response, then decode the json-formatted response.
//  var response = await http.get(url);
  var response = {'body': await _response, 'statusCode': 200};
//  if (response.statusCode == 200) {
  List<dynamic> challenges = convert.json
      .decode(response['body'])['values']
      .map((c) => Challenge.fromJson(c))
      .toList();
  print('Number of books about http: $challenges.');
  return challenges;
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
}

class _MyChallengesPageState extends State<MyChallengesPage> {
  _MyChallengesPageState() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _loadChallenges(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        List<Widget> children;

        if (snapshot.hasData) {
          children = <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Result: ${snapshot.data}'),
            )
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
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
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
