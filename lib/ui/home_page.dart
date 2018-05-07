import 'package:flutter/material.dart';
import 'package:selfbet/auth.dart';
import 'package:selfbet/widgets/home_body.dart';
import 'package:selfbet/widgets/bets_body.dart';
import 'package:selfbet/widgets/groups_body.dart';
import 'package:selfbet/widgets/money_body.dart';

enum PopupAction {
  signOut,
}

enum AppTab {
  home,
  bets,
  groups,
  money
}

class HomePage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  HomePage({this.auth, this.onSignedOut});

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppTab activeTab = AppTab.home;
  Widget currentBody = HomeBody();

  _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  void _signedOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      debugPrint(e);
    }
  }

  Widget bodySelector(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.home:
        return HomeBody();
      case AppTab.bets:
        return BetsBody();
      case AppTab.groups:
        return GroupsBody();
      case AppTab.money:
        return MoneyBody();
    }
    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Selfbet'),
        actions: <Widget>[
          new PopupMenuButton<PopupAction>(
            onSelected: (PopupAction selected) {
              setState(() {
                if (selected == PopupAction.signOut) {
                  _signedOut();
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupAction>>[
              const PopupMenuItem<PopupAction>(
                value: PopupAction.signOut,
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: bodySelector(activeTab),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title:  new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.casino),
            title: new Text('Bets'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.group),
            title:  new Text('Groups'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.attach_money),
            title:  new Text('Money'),
          ),
        ],
        currentIndex: AppTab.values.indexOf(activeTab),
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _updateTab(AppTab.values[index]);
        },
      ),
    );
  }
}

