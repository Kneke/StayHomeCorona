import 'package:app/ui/achievements_page.dart';
import 'package:app/ui/all_challenges_page.dart';
import 'package:app/ui/can_do_list_page.dart';
import 'package:app/ui/good_to_know_page.dart';
import 'package:app/ui/group_page.dart';
import 'package:app/ui/login_page.dart';
import 'package:app/service/authentication.dart';
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
        return MyChallengesPage();
      case 1:
        return AllChallengePage();
      case 2:
        return GroupPage();
      case 3:
        return AchievementsPage();
      case 4:
        return CanDoListPage();
      case 5:
        return GoodToKnowPage();
      default:
        return MyChallengesPage();
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
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
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
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text('Will Stayathome'),
                          accountEmail: Text('10 Punkte'),
                          currentAccountPicture:
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'lib/assets/home_icon.png'),
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
                        title: Text('Logout'),
                        onTap: () {
                          widget.auth.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
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
                              MaterialPageRoute(builder: (context) =>
                                  SharePage()),
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
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => SettingsPage()),);
                        },
                      ),
                    ),
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
