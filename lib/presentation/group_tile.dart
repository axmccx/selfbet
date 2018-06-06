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
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${group.name}",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text("Owner: ${group.owner}"),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Text(
                        "Total at Stake: \n\$${atStakeDouble.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
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
