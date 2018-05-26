import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class HomeScreen extends StatelessWidget {
  static final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool isLoading;
  final List<Group> groups;
  final int balance;

  HomeScreen(this.isLoading, this.groups, this.balance);

  Widget appBarSelector(BuildContext context, AppTab tab) {
    if (tab == AppTab.dashboard) {
      return AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          ExtraActionsContainer(),
        ],
      );
    } else if (tab == AppTab.bets) {
      return AppBar(
        title: Text("Bets"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (balance < 1) {
                final snackBar = SnackBar(
                  content: Text("You need a least \$1 to place a bet"),
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);
              debugPrint("You need a least \$1 to place a bet");
              } else if (groups.length == 0) {
                final snackBar = SnackBar(
                  content: Text("You're not a member of any group!"),
                );
                _scaffoldKey.currentState.showSnackBar(snackBar);
                debugPrint("You're not a member of any group!");
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return PlaceBetContainer();
                  },
                ));
              }
            },
          ),
        ],
      );
    } else if (tab == AppTab.groups) {
      return AppBar(
        title: Text("Groups"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return CreateGroup();
                },
              ));
            },

          ),
          IconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return JoinGroup();
                },
              ));
            },
          ),
        ],
      );
    } else {
      return AppBar(
        title: Text("Money"),
      );
    }
  }

  Widget bodySelector(AppTab tab) {
    if (tab == AppTab.dashboard) {
      return DashboardContainer();
    } else if (tab == AppTab.bets) {
      return BetsContainer();
    } else if (tab == AppTab.groups) {
      return GroupsContainer();
    } else {
      return MoneyContainer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab tab) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: appBarSelector(context, tab),
          body: bodySelector(tab),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}