import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class HomeScreen extends StatelessWidget {
  final bool isLoading;

  HomeScreen(this.isLoading);

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
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return PlaceBetContainer();
                },
              ));
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
      return Container();
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
          appBar: appBarSelector(context, tab),
          body: bodySelector(tab),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}