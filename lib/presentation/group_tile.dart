import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  final GestureTapCallback onTap;
  // final Function leave group
  // final Function change owner

  GroupTile({
    @required this.group,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector (
      onTap: onTap,
      child: Card(
        child: new Column(
          children: <Widget>[
            Text("${group.name}"),
            Text("${group.owner}"),
          ],
        ),
      ),
    );
  }
}
