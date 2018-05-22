import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';
import 'package:selfbet/containers/containers.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  final Function(BuildContext, Group) onTap;
  // final Function leave group
  // final Function change owner

  GroupTile({
    @required this.group,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double atStakeDouble = group.groupAtStake / 100;
    return GestureDetector (
      onTap: () { onTap(context, group); },
      child: Card(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${group.name}",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Text("Owner: ${group.owner}"),
                    Text("Total at Stake: \$${atStakeDouble.toStringAsFixed(2)}"),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                GroupPopupMenuContainer(group),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
