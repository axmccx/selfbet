import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

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
    return new GestureDetector (
      onTap: () { onTap(context, group); },
      child: Card(
        child: new Column(
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
      ),
    );
  }
}
