import 'package:app/ui/challenges_page.dart';
import 'package:app/ui/dashboard_page.dart';
import 'package:app/ui/settings_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        return DashboardPage();
      case 1:
        return ChallengePage();
      default:
        return DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
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
              title: Text('Home'),
              onTap: () => _onSelectDrawerItem(0),
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('Challenges'),
              onTap: () => _onSelectDrawerItem(1),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: _getPageBody(_selectedPageID),
    );
  }
}
