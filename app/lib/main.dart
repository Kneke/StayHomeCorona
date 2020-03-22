import 'package:app/ui/challenges_page.dart';
import 'package:app/ui/challenge_detail_page.dart';
import 'package:app/ui/my_challenges_page.dart';
import 'package:app/ui/settings_page.dart';
import 'package:app/ui/share_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(title: 'Stay Home Challenge'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageID = 0;

  _onSelectDrawerItem(int index) {
    setState(() => _selectedPageID = index);
    Navigator.of(context).pop(); // close the drawer
  }

  _getPageBody(int index) {
    switch (index) {
      case 0:
        return MyChallengesPage();
      case 1:
        return ChallengePage();
      default:
        return MyChallengesPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
        children: <Widget>[ Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Will Stayathome'),
              accountEmail: Text('10 Punkte'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/assets/home_icon.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Meine Challenges'),
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: Icon(Icons.apps),
              title: Text('Alle Challenges'),
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Gruppen'),
              onTap: () => _onSelectDrawerItem(2),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Erfolge'),
              onTap: () => _onSelectDrawerItem(3),
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Kann man mal machen'),
              onTap: () => _onSelectDrawerItem(4),
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Gut zu Wissen'),
              onTap: () => _onSelectDrawerItem(5),
            ),
            ],
        ),
        ),
            Container(
              child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Teilen'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SharePage()),
                      );
                    },
                  ),
                )
            ),
          Container(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 15, bottom: 30),
                  leading: Icon(Icons.settings),
                  title: Text('Einstellungen'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              )
          ),
          ],
        ),
        ),
      body: _getPageBody(_selectedPageID),
    );
  }
}
