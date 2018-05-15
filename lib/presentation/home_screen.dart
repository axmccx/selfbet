import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class HomeScreen extends StatelessWidget {
  Widget bodySelector(AppTab activeTab) {
    if (activeTab == AppTab.dashboard) {
      return Dashboard();
    } else if (activeTab == AppTab.bets) {
      return new Container();
    } else if (activeTab == AppTab.groups) {
      return new Container();
    } else {
      return new Money();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: new AppBar(
            title: new Text("Selfbet"),
          ),
          body: bodySelector(activeTab),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}