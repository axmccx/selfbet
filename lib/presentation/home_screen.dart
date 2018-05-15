import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class HomeScreen extends StatelessWidget {
  Widget appBarSelector(AppTab tab) {
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
      );
    } else if (tab == AppTab.groups) {
      return AppBar(
        title: Text("Groups"),
      );
    } else {
      return AppBar(
        title: Text("Money"),
      );
    }
  }

  Widget bodySelector(AppTab tab) {
    if (tab == AppTab.dashboard) {
      return Dashboard();
    } else if (tab == AppTab.bets) {
      return Container();
    } else if (tab == AppTab.groups) {
      return Container();
    } else {
      return Money();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ActiveTab(
      builder: (BuildContext context, AppTab tab) {
        return Scaffold(
          appBar: appBarSelector(tab),
          body: bodySelector(tab),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}