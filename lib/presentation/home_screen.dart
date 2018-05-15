import 'package:flutter/material.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class HomeScreen extends StatelessWidget {
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
          appBar: AppBar(
            title: Text("Selfbet"),
          ),
          body: bodySelector(tab),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}