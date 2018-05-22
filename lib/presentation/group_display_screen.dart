import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:selfbet/models/models.dart';

class GroupDisplayScreen extends StatelessWidget {
  final Group group;
  final List<UserEntity> members;

  GroupDisplayScreen({
    @required this.group,
    @required this.members,
  });

  @override
  Widget build(BuildContext context) {
    double atStakeDouble = group.groupAtStake / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text("${group.name}"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Group Name: ${group.name}",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Text(
              "Stake in Group: \$${atStakeDouble.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Text("Members:"),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return UserRow(members[index]);
                },
                itemCount: members.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserRow extends StatelessWidget {
  final UserEntity user;
  const UserRow(this.user);

  @override
  Widget build(BuildContext context) {
    double atStakeDouble = user.atStake / 100;
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(user.name),
          subtitle: Text("Total at Stake: \$${atStakeDouble.toStringAsFixed(2)}"),
        ),
        Divider(),
      ],
    );
  }
}
