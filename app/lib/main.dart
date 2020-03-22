import 'package:app/ui/all_challenges_page.dart';
import 'package:app/service/authentication.dart';
import 'package:app/ui/dashboard_page.dart';
import 'package:app/ui/login_page.dart';
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
      home: HomePage(auth: Auth()),
    );
  }
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth}) : super(key: key);

  final BaseAuth auth;

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
        return AllChallengePage();
      default:
        return DashboardPage();
    }
  }

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  String _userMail = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
          _userMail = user?.email;
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      print(user);
      setState(() {
        _userId = user.uid.toString();
        _userMail = user.email;
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      _userMail = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Stay Home Challenge'),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(_userMail),
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
                    leading: Icon(Icons.casino),
                    title: Text('All Challenges'),
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
                  ListTile(
                    title: Text('Logout'),
                    onTap: () {
                      widget.auth.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            body: _getPageBody(_selectedPageID),
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
