import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/presentation/display_group_screen.dart';

class DisplayGroup extends StatelessWidget {
  final Group group;

  DisplayGroup(this.group);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<UserEntity>>(
      converter: (Store<AppState> store) => store.state.groupMembers,
      builder: (context, members) {
        return DisplayGroupScreen(
          group: group,
          members: members,
        );
      },
    );
  }
}